part of netflix;

class ContentList extends StatelessWidget {
  final String title;
  final List contentList;
  final bool isOriginals;
  final Function onTap;

  const ContentList({
    Key key,
    @required this.title,
    @required this.contentList,
    this.isOriginals = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.contentList);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: isOriginals ? 500.0 : 220.0,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: contentList.length,
              itemBuilder: (BuildContext context, int index) {
                final Result item = contentList[index];
                return GestureDetector(
                  onTap: () => onTap(item, 99),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: isOriginals ? 400.0 : 200.0,
                    width: isOriginals ? 200.0 : 130.0,
                    child: Image.network("https://cors.bridged.cc/" + item.image, fit: BoxFit.cover)
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
