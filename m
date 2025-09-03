Return-Path: <linux-tip-commits+bounces-6430-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D2B41B07
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 12:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD13A566249
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52A2E719B;
	Wed,  3 Sep 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ZEIBxFv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="16+/lIkk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349C2E3AE3;
	Wed,  3 Sep 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893863; cv=none; b=J2MIi89bhkYC6r3130Qn9upZe71UW/vMaZW3srZHjtYFQwl1a01akdquyMGflln4T0a1aubfWKuQ3nKEBhotX7KRVv6RijgY/k+7e5Aj8nkYWDFIdQVpgC8d4ZCXWla98a4yofAQcq6vvdCxsN81DDSGiQ5lRlc8XGxU7YZK6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893863; c=relaxed/simple;
	bh=Oh1tZiRLCJbdLdefDIXipB1rYaVFXTunh/gp8oe+EZ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T6GeAULQiRaj1AXl/aeWFhBdrplXXATh2inlRI2hd0QTl+r6QBiBQYCkiMW24mBgeNY2pbtS+1KHsrioKBD8m3tigGk/UVRee/QCZVMoXmg7IyAAF8DNeh5NKaU0OVNpE9ZKG47m7B+NTJnOR9NI5v9+VpULOLIn+6AkrBbyDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ZEIBxFv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=16+/lIkk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 10:04:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756893860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LXGonld1P9fTvlOcBtclZeFVhmaFv655rpD18CpufI=;
	b=0ZEIBxFvSywguiQQtV50FUjgSJsWU0QJZdaY8QJMr6ToXs2tI4MbtJNcradLo9UBXyuWPa
	6DSjbfaKrRq01Ka5j2p8z7KqP6vrLSmycbBhPKbYE8qcJCA5iqztQmoMHF2vHkiLzTgxly
	hh7UEcC+Bsed+aeOEY9ZwWdGVr/H7uQ/1vlnDPwVOVF7224nCY9+hv2+HUgUpYD1Sfw+NM
	xtPqy2cmyhi/W6cSt2qI/BWZQcQTyqCmmdeFW2eG2VQA7qlT18pY+TkRzTCb37fnp0PIcE
	QzKNIr4R1oLCfSrD57p366s12QUUEuduIIFFuVwBo2RZDeld2R7VbDc0xpJOJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756893860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LXGonld1P9fTvlOcBtclZeFVhmaFv655rpD18CpufI=;
	b=16+/lIkk+YN7oOBFkGflAe3vIEIB8DIZ42kRRFwCMMrNiBTxFQzm/61QFSmv70OZQtkXeK
	1LzxcHr1dOfdcECQ==
From: "tip-bot2 for Bjorn Helgaas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] jiffies: Remove obsolete SHIFTED_HZ comment
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250825203425.796034-1-helgaas@kernel.org>
References: <20250825203425.796034-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175689385917.1920.7041259214583285236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0a26e5eb78fb1627beb8e3eb172737f8492d2799
Gitweb:        https://git.kernel.org/tip/0a26e5eb78fb1627beb8e3eb172737f8492=
d2799
Author:        Bjorn Helgaas <bhelgaas@google.com>
AuthorDate:    Mon, 25 Aug 2025 15:34:23 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 11:59:28 +02:00

jiffies: Remove obsolete SHIFTED_HZ comment

b3c869d35b9b ("jiffies: Remove compile time assumptions about
CLOCK_TICK_RATE") removed the last definition of SHIFTED_HZ but left
behind comments about it.  Remove the comments as well.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250825203425.796034-1-helgaas@kernel.org

---
 include/linux/jiffies.h | 2 +-
 include/vdso/jiffies.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 91b2078..0d1927d 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -61,7 +61,7 @@
=20
 extern void register_refined_jiffies(long clock_tick_rate);
=20
-/* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
+/* TICK_USEC is the time between ticks in usec */
 #define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
=20
 /* USER_TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
diff --git a/include/vdso/jiffies.h b/include/vdso/jiffies.h
index 2f9d596..8ca04a1 100644
--- a/include/vdso/jiffies.h
+++ b/include/vdso/jiffies.h
@@ -5,7 +5,7 @@
 #include <asm/param.h>			/* for HZ */
 #include <vdso/time64.h>
=20
-/* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
+/* TICK_NSEC is the time between ticks in nsec */
 #define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
=20
 #endif /* __VDSO_JIFFIES_H */

