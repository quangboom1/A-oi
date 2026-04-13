import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import '../../widgets/main_header.dart';
import 'knowledge_detail_screen.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'Tất cả',
    'Video',
    'Dinh dưỡng',
    'Sức khỏe',
    'Phát triển',
    'Giấc ngủ',
    'Mẹo hay',
  ];

  final List<Map<String, dynamic>> _articles = [
    {
      'title': 'Hướng dẫn massage cho bé ngủ ngon (Video)',
      'category': 'Video',
      'time': '3:45',
      'image': 'assets/knowledge/massage-be.jpg',
      'isFeatured': true,
      'isVideo': true,
      'videoUrl': 'assets/video/video_massage.mp4',
      'abstract': 'Massage đúng cách giúp bé thư giãn, kích thích hệ tiêu hóa và cải thiện chất lượng giấc ngủ...',
      'content': 'Trong video này, chuyên gia Nguyễn Hải Yến sẽ hướng dẫn các mẹ từng bước massage cơ bản cho bé sơ sinh. \n\n1. Chuẩn bị không gian ấm áp, yên tĩnh.\n2. Sử dụng dầu massage chuyên dụng cho trẻ.\n3. Các động tác massage chân, bụng và tay nhẹ nhàng.\n\nLưu ý: Không massage khi bé vừa ăn no hoặc khi bé đang quấy khóc.',
    },
    {
      'title': 'Bí quyết rèn luyện giấc ngủ cho bé 0-3 tháng',
      'category': 'Giấc ngủ',
      'time': '5 phút đọc',
      'image': 'assets/knowledge/ren-luyen-giac-ngu.jpg',
      'isFeatured': false,
      'abstract': 'Giấc ngủ đóng vai trò cực kỳ quan trọng trong việc phát triển trí não và thể chất của trẻ sơ sinh...',
      'content': 'Giấc ngủ của trẻ sơ sinh (0-3 tháng tuổi) thường không theo một chu kỳ cố định. Tuy nhiên, các mẹ có thể bắt đầu rèn luyện nếp sinh hoạt cho bé bằng cách phân biệt ngày và đêm. Ban ngày, hãy để bé tiếp xúc với ánh sáng tự nhiên và tiếng động sinh hoạt bình thường. Ngược lại, vào ban đêm, hãy giữ không gian tối và yên tĩnh tuyệt đối.\n\nNgoài ra, việc thiết lập một "quy trình đi ngủ" (Bedtime Routine) như tắm nước ấm, massage nhẹ nhàng và hát ru cũng giúp bé nhận biết tín hiệu đã đến giờ đi ngủ.',
    },
    {
      'title': 'Chế độ dinh dưỡng cho mẹ sau sinh mổ',
      'category': 'Dinh dưỡng',
      'time': '8 phút đọc',
      'image': 'assets/knowledge/Goi-y-che-do-dinh-duong-cho-me-sau-sinh-mo.jpg',
      'isFeatured': false,
      'abstract': 'Dinh dưỡng hợp lý giúp mẹ nhanh lành vết thương và có đủ sữa cho bé...',
      'content': 'Sau khi sinh mổ, hệ tiêu hóa của mẹ còn yếu, do đó nên bắt đầu bằng các món ăn nhẹ, dễ tiêu như cháo, súp. Khi vết mổ đã ổn định, mẹ cần bổ sung đa dạng các nhóm chất: đạm từ thịt nạc, cá, trứng; canxi từ sữa và các loại hạt; cùng lượng lớn vitamin từ rau xanh và trái cây.\n\nĐặc biệt, mẹ nên uống đủ 2-3 lít nước mỗi ngày để hỗ trợ quá trình tiết sữa và ngăn ngừa táo bón sau sinh.',
    },
    {
      'title': 'Dấu hiệu bé mọc răng và cách chăm sóc',
      'category': 'Sức khỏe',
      'time': '4 phút đọc',
      'image': 'assets/knowledge/dau-hieu-moc-rang.jpg',
      'isFeatured': false,
      'abstract': 'Bé thường quấy khóc và hay chảy nước dãi khi bước vào giai đoạn mọc răng...',
      'content': 'Mọc răng là một cột mốc quan trọng nhưng cũng đầy "thử thách" đối với bé. Các dấu hiệu thường gặp bao gồm: lợi sưng đỏ, chảy nước dãi nhiều, thích gặm đồ vật và thỉnh thoảng sốt nhẹ.\n\nĐể giúp bé bớt khó chịu, mẹ có thể dùng khăn sạch nhúng nước mát để lau lợi cho bé hoặc cho bé dùng các loại vòng gặm nướu đã được làm lạnh.',
    },
    {
      'title': 'Cột mốc phát triển của bé trong năm đầu đời',
      'category': 'Phát triển',
      'time': '6 phút đọc',
      'image': 'assets/knowledge/cot-moc-phat-trien-cua-be.jpg',
      'isFeatured': false,
      'abstract': 'Mỗi đứa trẻ là một cá thể riêng biệt với tốc độ phát triển khác nhau...',
      'content': 'Trong năm đầu tiên, bé sẽ trải qua những thay đổi kỳ diệu. Từ việc biết lẫy lúc 3-4 tháng, biết ngồi lúc 6 tháng, biết bò lúc 8-9 tháng và bắt đầu những bước đi đầu đời quanh cột mốc 12 tháng.\n\nCha mẹ hãy luôn bên cạnh cổ vũ và tạo điều kiện an toàn để bé thoải mái khám phá thế giới xung quanh. Tuy nhiên, đừng quá lo lắng nếu bé chậm hơn các bạn khác một chút, hãy tham khảo ý kiến bác sĩ nếu có dấu hiệu chậm phát triển rõ rệt.',
    },
    {
      'title': 'Các món cháo giàu kẽm cho bé tập ăn dặm',
      'category': 'Dinh dưỡng',
      'time': '7 phút đọc',
      'image': 'assets/knowledge/chao-dinh-duong.jpg',
      'isFeatured': false,
      'abstract': 'Kẽm giúp bé ăn ngon miệng và tăng cường hệ miễn dịch thực sự...',
      'content': 'Kẽm là vi chất quan trọng giúp bé phát triển chiều cao và trí tuệ. Mẹ có thể bổ sung kẽm cho bé qua các món cháo như: cháo lươn rau ngót, cháo thịt bò cà rốt, hoặc cháo cua biển.\n\nLưu ý khi nấu cháo cho bé tập ăn dặm là cần xay nhuyễn thức ăn và không nên nêm thêm đường muối cho bé dưới 1 tuổi.',
    },
    {
      'title': 'Lịch tiêm phòng đầy đủ cho bé sơ sinh',
      'category': 'Sức khỏe',
      'time': '10 phút đọc',
      'image': 'assets/knowledge/mui-tiem-cho-tre-so-sinh.png',
      'isFeatured': false,
      'abstract': 'Tiêm chủng là cách tốt nhất để bảo vệ bé khỏi các bệnh nguy hiểm...',
      'content': 'Lịch tiêm chủng mở rộng và dịch vụ cung cấp các mũi tiêm quan trọng như: Lao (BCG), Viêm gan B, 5 trong 1 (ho gà, bạch hầu, uốn ván, bại liệt, Hib), Phế cầu, và Rota virus.\n\nSau khi tiêm, bé có thể bị sốt nhẹ hoặc sưng đau tại chỗ tiêm. Mẹ nên theo dõi sát sao nhiệt độ của bé và chườm mát nếu cần thiết.',
    },
  ];


  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 40,
      desktop: Responsive.getWidth(context) * 0.1,
    );

    // -- Filtering Logic --
    final String selectedCategory = _categories[_selectedCategoryIndex];
    final List<Map<String, dynamic>> filteredArticles = _articles.where((article) {
      if (selectedCategory == 'Tất cả') return true;
      return article['category'] == selectedCategory;
    }).toList();

    // Determine which article to feature for the current category
    final featuredArticle = filteredArticles.firstWhere(
      (article) => article['isFeatured'] == true,
      orElse: () => filteredArticles.isNotEmpty ? filteredArticles.first : _articles.first,
    );

    // List of secondary articles (not the one being featured)
    final secondaryArticles = filteredArticles.where((a) => a != featuredArticle).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Main Header ──────────────────────────────────────
              SliverToBoxAdapter(
                child: MainHeader(horizontalPadding: horizontalPadding),
              ),

              // ── Search & Title Section ──────────────────────────────────────────
              SliverPadding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Khám phá',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppTheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Kiến thức',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.onSurface,
                              letterSpacing: -0.8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSearchBar(),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              // ── Categories Slider ─────────────────────────────────────────
              SliverToBoxAdapter(
                child: _buildCategoriesList(horizontalPadding),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── Featured Section Title ────────────────────────────────────
              if (filteredArticles.isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nổi bật',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        Text(
                          'Xem tất cả',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // ── Featured Article Card ──────────────────────────────────────
              if (filteredArticles.isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverToBoxAdapter(
                    child: _buildFeaturedCard(featuredArticle),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── Latest Section Title ──────────────────────────────────────
              if (secondaryArticles.isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Dành cho bạn',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // ── Articles Feed ─────────────────────────────────────────────
              if (secondaryArticles.isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 120),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final article = secondaryArticles[index];
                        return _buildArticleItem(article);
                      },
                      childCount: secondaryArticles.length,
                    ),
                  ),
                )
              else if (filteredArticles.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.search_off_rounded, size: 48, color: AppTheme.onSurfaceVariant.withOpacity(0.3)),
                          const SizedBox(height: 16),
                          Text(
                            'Không tìm thấy bài viết nào',
                            style: GoogleFonts.inter(color: AppTheme.onSurfaceVariant.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: AppTheme.onSurfaceVariant, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() {}), // Trigger rebuild for search (optional detail)
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm kiến thức, lời khuyên...',
                      hintStyle: GoogleFonts.inter(
                        color: AppTheme.onSurfaceVariant.withOpacity(0.5),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.tune_rounded, size: 16, color: AppTheme.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesList(double horizontalPadding) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = _selectedCategoryIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategoryIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: isSelected ? AppTheme.primary : Colors.white.withOpacity(0.8),
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          )
                        ]
                      : [],
                ),
                child: Text(
                  _categories[index],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : AppTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFeaturedCard(Map<String, dynamic> article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KnowledgeDetailScreen(article: article),
          ),
        );
      },
      child: Container(
        height: 420,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: article['image'].startsWith('http')
                    ? Image.network(article['image'], fit: BoxFit.cover)
                    : Image.asset(article['image'], fit: BoxFit.cover),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black12,
                        Colors.black.withOpacity(0.35),
                        Colors.black.withOpacity(0.9),
                      ],
                      stops: const [0.3, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
              // Play Button for Video
              if (article['isVideo'] == true)
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                ),
              // Content
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Text(
                        article['category'],
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      article['title'],
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.25,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      article['abstract'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, color: Colors.white60, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          article['isVideo'] == true ? 'Video • ${article['time']}' : article['time'],
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleItem(Map<String, dynamic> article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KnowledgeDetailScreen(article: article),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      article['image'].startsWith('http')
                          ? Image.network(article['image'], fit: BoxFit.cover)
                          : Image.asset(article['image'], fit: BoxFit.cover),
                      if (article['isVideo'] == true)
                        Container(
                          color: Colors.black.withOpacity(0.2),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill_rounded,
                                color: Colors.white, size: 30),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['category'],
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article['title'],
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.onSurface,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: 14,
                            color: AppTheme.onSurfaceVariant.withOpacity(0.5)),
                        const SizedBox(width: 6),
                        Text(
                          article['isVideo'] == true
                              ? 'Video • ${article['time']}'
                              : article['time'],
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}




