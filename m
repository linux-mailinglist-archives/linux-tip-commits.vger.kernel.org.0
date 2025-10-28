Return-Path: <linux-tip-commits+bounces-7028-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452CC13B86
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Oct 2025 10:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEF1B560388
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Oct 2025 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC32EA473;
	Tue, 28 Oct 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2TQvvALG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKvXqCjB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD532D6608;
	Tue, 28 Oct 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642347; cv=none; b=pCm9IzhWbBmAML4jk2eX4e7oDika794khJEIQAUt8m9bwsC4P+vv0gc4ZC065xIg3PCZcf8PKnOM5dTY7tGBa/wIbelIVTz9FhSQrsnLcJfCV0P9scpdXJ3ZyoKPXCO5mRqxLZgMDKnDtx7CvFANosOUku/bP+fnc7grfr+GyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642347; c=relaxed/simple;
	bh=HGrLfTOeY2O2uxgYygF1RSH+PaOHNzQ6+CD1EYMKqPs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gVugv40zHXm73D5sHunjZEw4OjpYkxUS4ev4mYHF61wY2pl8LBg7mJGq1C/P4OY+vW45JNpqONdam6U3YLi8Mt9mKaOKZFQRWd1sMKxJDk4CxdzvQgdDVKmE3e6J7lPSrAqC8Xfln+yCl5ARnBW3A2zomPp3RRbQg2JYN3fXYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2TQvvALG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKvXqCjB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 09:05:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761642343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PKa5y7aV+xr5zQhbCglQpi2jNNtp2DgckldxLP8SFPI=;
	b=2TQvvALGG7qygmyO1KtyuKR4r8nSBZ0h1vqnvOcrlh9QEVd2h5J4ioqecaNfLa4ODFxKaZ
	GPc3nrieqyUa5D0FA9HVtk9nU5xsqcVo9m6WNRiyB5JOaIA08gDYfK7e1aW/T26ZH15IY+
	fAXQR8DLQm8RZOdwFfRQ6szxX8yPPXP2s9Y50KLbjiHxMUewAVJGzy0R57s4SMIPRQPOxa
	te47Rz8gZV76Q2vCVKpJCTECVNnp4HWdhQiMTUT0EbCUtUwyNiQ8PE7wtAkBrpxEauTzyA
	tGOJIcpnHjNsIDm1SE0lHsAHQ2pUki5FF4ZzZa0bh5eJL1cZawE/AbJW8XeEOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761642343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PKa5y7aV+xr5zQhbCglQpi2jNNtp2DgckldxLP8SFPI=;
	b=kKvXqCjB3IWXMHBhY3AgTH6QCJ5wOialsm0PWaHMNvR/BNdKOserYeliFWD4rA4bDi1pVg
	xab9W7ug/4XnKJCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Allow KASAN to fail optimizing
Cc: kernel test robot <lkp@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176164233999.2601451.2569060185720432569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b94d45b6bbb42571ec225d3be0e7457c8765a5b4
Gitweb:        https://git.kernel.org/tip/b94d45b6bbb42571ec225d3be0e7457c876=
5a5b4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 28 Oct 2025 09:56:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Oct 2025 09:58:57 +01:00

seqlock: Allow KASAN to fail optimizing

Some KASAN builds are failing to properly optimize this code --
luckily we don't care about core quality for KASAN builds, so just
exclude it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Closes: https://lore.kernel.org/oe-kbuild-all/202510251641.idrNXhv5-lkp@intel=
.com/
---
 include/linux/seqlock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index b7bcc41..a8a8661 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1234,11 +1234,14 @@ static inline void __scoped_seqlock_cleanup(struct ss=
_tmp *sst)
=20
 extern void __scoped_seqlock_invalid_target(void);
=20
-#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000
+#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000) || defined(CON=
FIG_KASAN)
 /*
  * For some reason some GCC-8 architectures (nios2, alpha) have trouble
  * determining that the ss_done state is impossible in __scoped_seqlock_next=
()
  * below.
+ *
+ * Similarly KASAN is known to confuse compilers enough to break this. But we
+ * don't care about code quality for KASAN builds anyway.
  */
 static inline void __scoped_seqlock_bug(void) { }
 #else

