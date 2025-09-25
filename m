Return-Path: <linux-tip-commits+bounces-6727-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A755FBA18C1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50D2189BF74
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F23B322A10;
	Thu, 25 Sep 2025 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQGPTt/g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qn6ZvjhV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332F322521;
	Thu, 25 Sep 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835976; cv=none; b=Z/9mHpDFtN+jgBBjDvZ5xlWZ/OiN0cChbjyF8Ccb7kWn1ONJzwxTFsD8NfP6ul6ODRuj+OzEi3gs4Z66qSGgkWT4avI2p400Xh+m7UWR9vSiB70m8SIUOsO4/VwZRE0axDoV0ZqnQUo3VdC0rH6iXUHPHCXJ4ow9GOGPBpPgXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835976; c=relaxed/simple;
	bh=CsWxQ//97wbZK4Wj0f9sUw7Aq1LnL6UVjWPM5wknALo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qL7C6Iokej3y+2PiFLOxICjrkckS44rScqP2vgAf2efdooa74nMgo5Hpb0t3cgBMPQOICaFTLFM+kelfIQ65NMeH8Q+sNgTZp+XQH3WNKdzSbmm0kb/QH6+pelIMgId54jfGaDbMMUO8mUcub4K20Wrq506QakOVC6KocWaZi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQGPTt/g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qn6ZvjhV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Sm1XoBUFCnZmX7UmC0KezR+iMsUsksWRyosjDeeszu4=;
	b=TQGPTt/gugHCZxafszBslskOuB1v3fYrJljy5eotgY3GjtnUyOYxvQ+7rX0oxmp8I3BBpn
	z66quCblxylCZKG8grYJ3mSyakdW0PXlfzWaBUt2HgOmuy31v7Zqcdp1VurNf15mFkMkLQ
	uYfVQUj1oz8ZOB4VfI9Gv8LtWo3x3jhrqyXDab2Pbg5mGDQWpt9L7rkccyeylaO8pu5ngV
	eju917UHG2nko6rtE6JbJjCXaNPW3eih2GFr5WPHVrbZDDdwbad3mgo8H9LCk9Owk/LX23
	GEIDlhTzMCqHzjjotZuyDim1Ol/+yWoxAio3JSd8AFF4EokoeO5fZx2jcbAKKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Sm1XoBUFCnZmX7UmC0KezR+iMsUsksWRyosjDeeszu4=;
	b=Qn6ZvjhVA9seugWuL3ERjcidAHKh45hGF4Y2CpU7NPKyb5ydBiqckj8JhtEq7U4c+d6Ard
	NumODVuA5rswGFCw==
From: "tip-bot2 for Brian Masney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/ingenic-sysost: Convert
 from round_rate() to determine_rate()
Cc: Brian Masney <bmasney@redhat.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883597151.709179.3979269480320359783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     21b8a635f3b3d6a165fa257808ed381c13c72e9b
Gitweb:        https://git.kernel.org/tip/21b8a635f3b3d6a165fa257808ed381c13c=
72e9b
Author:        Brian Masney <bmasney@redhat.com>
AuthorDate:    Sun, 10 Aug 2025 18:37:10 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:41:50 +02:00

clocksource/drivers/ingenic-sysost: Convert from round_rate() to determine_ra=
te()

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
appended to the "under-the-cut" portion of the patch.

While changes are being made to 'struct clk_ops', let's also go ahead
and fix the formatting of set_rate so that everything lines up as
expected.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250810-clocksource-round-rate-v1-1-486ef53e=
45eb@redhat.com
---
 drivers/clocksource/ingenic-sysost.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingen=
ic-sysost.c
index cb6fc2f..e79cfb0 100644
--- a/drivers/clocksource/ingenic-sysost.c
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -127,18 +127,23 @@ static u8 ingenic_ost_get_prescale(unsigned long rate, =
unsigned long req_rate)
 	return 2; /* /16 divider */
 }
=20
-static long ingenic_ost_round_rate(struct clk_hw *hw, unsigned long req_rate,
-		unsigned long *parent_rate)
+static int ingenic_ost_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
-	unsigned long rate =3D *parent_rate;
+	unsigned long rate =3D req->best_parent_rate;
 	u8 prescale;
=20
-	if (req_rate > rate)
-		return rate;
+	if (req->rate > rate) {
+		req->rate =3D rate;
=20
-	prescale =3D ingenic_ost_get_prescale(rate, req_rate);
+		return 0;
+	}
+
+	prescale =3D ingenic_ost_get_prescale(rate, req->rate);
=20
-	return rate >> (prescale * 2);
+	req->rate =3D rate >> (prescale * 2);
+
+	return 0;
 }
=20
 static int ingenic_ost_percpu_timer_set_rate(struct clk_hw *hw, unsigned lon=
g req_rate,
@@ -175,14 +180,14 @@ static int ingenic_ost_global_timer_set_rate(struct clk=
_hw *hw, unsigned long re
=20
 static const struct clk_ops ingenic_ost_percpu_timer_ops =3D {
 	.recalc_rate	=3D ingenic_ost_percpu_timer_recalc_rate,
-	.round_rate		=3D ingenic_ost_round_rate,
-	.set_rate		=3D ingenic_ost_percpu_timer_set_rate,
+	.determine_rate =3D ingenic_ost_determine_rate,
+	.set_rate	=3D ingenic_ost_percpu_timer_set_rate,
 };
=20
 static const struct clk_ops ingenic_ost_global_timer_ops =3D {
 	.recalc_rate	=3D ingenic_ost_global_timer_recalc_rate,
-	.round_rate		=3D ingenic_ost_round_rate,
-	.set_rate		=3D ingenic_ost_global_timer_set_rate,
+	.determine_rate =3D ingenic_ost_determine_rate,
+	.set_rate	=3D ingenic_ost_global_timer_set_rate,
 };
=20
 static const char * const ingenic_ost_clk_parents[] =3D { "ext" };

