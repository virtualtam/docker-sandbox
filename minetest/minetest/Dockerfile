FROM archlinux/base:latest

RUN pacman -Sy --noconfirm \
        git \
        minetest-server \
        vim \
    && useradd \
        --create-home \
        --home-dir /home/minetestserver \
        minetestserver \
    && mkdir -p \
        /minetest \
        /minetest/games \
        /minetest/mods \
        /minetest/worlds \
    && ln -sf /minetest /home/minetestserver/.minetest \
    && chown -R minetestserver:minetestserver /minetest

USER minetestserver
WORKDIR /minetest

CMD ["minetestserver"]

EXPOSE 30000
