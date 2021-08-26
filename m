Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28263F8C16
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbhHZQ0N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243087AbhHZQ0H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:07 -0400
Date:   Thu, 26 Aug 2021 16:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJsuCSeEv8PqnDUy9v4jlMUdfNKe6m+xdnOpoZZYrRU=;
        b=Q0D0QrKXV3C/xp3HsyIyIncz0/ZRbvhCYTmkhDgVOIm/jwFJ3U0XaQOx2dWx8rLLH1iQT5
        SEqeKl/7kg33jrBMET93Dmu5hFfELP4qz5hQ2EeL+Dij/qny1NzwtV1u0fqePqYZkNf17k
        BptBSsNjPFIyy94JLIgRSnQ3q2702bHsh4pyt4OnpfGFnf9hKfeItKDnxXyAV08N4ZYNC4
        N/CnoiK8R2ZbWhoE3t9rL27/STtBbT9Cvuk9Jw7iGtKmd/yChA7D0ZwDWVOSOoWfjM0mr7
        vPw7iFBTsDo1lWaJ3+clKX/MDeWIWdFFxzL+sFTLENwzR+mbLs9kB76M8twGbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJsuCSeEv8PqnDUy9v4jlMUdfNKe6m+xdnOpoZZYrRU=;
        b=/dgJEZqWAClUgDAytLlPEYF89gE5JSqGoDwJnQZ7+CuHBWOiCACayl0nUch2C/pF8QE0Ox
        9O7xzizsbOSoIgBA==
From:   "tip-bot2 for Phong Hoang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_cmt: Fix wrong setting if
 don't request IRQ for clock source channel
Cc:     Phong Hoang <phong.hoang.wz@renesas.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123443.73334-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210422123443.73334-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <162999511776.25758.7268833161474513428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     be83c3b6e7b8ff22f72827a613bf6f3aa5afadbb
Gitweb:        https://git.kernel.org/tip/be83c3b6e7b8ff22f72827a613bf6f3aa5a=
fadbb
Author:        Phong Hoang <phong.hoang.wz@renesas.com>
AuthorDate:    Thu, 22 Apr 2021 14:34:43 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 13 Aug 2021 20:26:29 +02:00

clocksource/drivers/sh_cmt: Fix wrong setting if don't request IRQ for clock =
source channel

If CMT instance has at least two channels, one channel will be used
as a clock source and another one used as a clock event device.
In that case, IRQ is not requested for clock source channel so
sh_cmt_clock_event_program_verify() might work incorrectly.
Besides, when a channel is only used for clock source, don't need to
re-set the next match_value since it should be maximum timeout as
it still is.

On the other hand, due to no IRQ, total_cycles is not counted up
when reaches compare match time (timer counter resets to zero),
so sh_cmt_clocksource_read() returns unexpected value.
Therefore, use 64-bit clocksoure's mask for 32-bit or 16-bit variants
will also lead to wrong delta calculation. Hence, this mask should
correspond to timer counter width, and above function just returns
the raw value of timer counter register.

Fixes: bfa76bb12f23 ("clocksource: sh_cmt: Request IRQ for clock event device=
 only")
Fixes: 37e7742c55ba ("clocksource/drivers/sh_cmt: Fix clocksource width for 3=
2-bit machines")
Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210422123443.73334-1-niklas.soderlund+renes=
as@ragnatech.se
---
 drivers/clocksource/sh_cmt.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index d7ed99f..dd0956a 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -579,7 +579,8 @@ static int sh_cmt_start(struct sh_cmt_channel *ch, unsign=
ed long flag)
 	ch->flags |=3D flag;
=20
 	/* setup timeout if no clockevent */
-	if ((flag =3D=3D FLAG_CLOCKSOURCE) && (!(ch->flags & FLAG_CLOCKEVENT)))
+	if (ch->cmt->num_channels =3D=3D 1 &&
+	    flag =3D=3D FLAG_CLOCKSOURCE && (!(ch->flags & FLAG_CLOCKEVENT)))
 		__sh_cmt_set_next(ch, ch->max_match_value);
  out:
 	raw_spin_unlock_irqrestore(&ch->lock, flags);
@@ -621,20 +622,25 @@ static struct sh_cmt_channel *cs_to_sh_cmt(struct clock=
source *cs)
 static u64 sh_cmt_clocksource_read(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch =3D cs_to_sh_cmt(cs);
-	unsigned long flags;
 	u32 has_wrapped;
-	u64 value;
-	u32 raw;
=20
-	raw_spin_lock_irqsave(&ch->lock, flags);
-	value =3D ch->total_cycles;
-	raw =3D sh_cmt_get_counter(ch, &has_wrapped);
+	if (ch->cmt->num_channels =3D=3D 1) {
+		unsigned long flags;
+		u64 value;
+		u32 raw;
=20
-	if (unlikely(has_wrapped))
-		raw +=3D ch->match_value + 1;
-	raw_spin_unlock_irqrestore(&ch->lock, flags);
+		raw_spin_lock_irqsave(&ch->lock, flags);
+		value =3D ch->total_cycles;
+		raw =3D sh_cmt_get_counter(ch, &has_wrapped);
+
+		if (unlikely(has_wrapped))
+			raw +=3D ch->match_value + 1;
+		raw_spin_unlock_irqrestore(&ch->lock, flags);
+
+		return value + raw;
+	}
=20
-	return value + raw;
+	return sh_cmt_get_counter(ch, &has_wrapped);
 }
=20
 static int sh_cmt_clocksource_enable(struct clocksource *cs)
@@ -697,7 +703,7 @@ static int sh_cmt_register_clocksource(struct sh_cmt_chan=
nel *ch,
 	cs->disable =3D sh_cmt_clocksource_disable;
 	cs->suspend =3D sh_cmt_clocksource_suspend;
 	cs->resume =3D sh_cmt_clocksource_resume;
-	cs->mask =3D CLOCKSOURCE_MASK(sizeof(u64) * 8);
+	cs->mask =3D CLOCKSOURCE_MASK(ch->cmt->info->width);
 	cs->flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
=20
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used as clock source\n",
