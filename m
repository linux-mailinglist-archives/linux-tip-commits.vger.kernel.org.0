Return-Path: <linux-tip-commits+bounces-6453-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E1B43788
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE6997AFCF1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950252F83C0;
	Thu,  4 Sep 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ckTK94i3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSQHX8KT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3052EB87B;
	Thu,  4 Sep 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979327; cv=none; b=bWcgFmbchxGBpAt/YK9IujYrJYpFwJhK8ZyFeOu1FmyL5zWyWf0N1gJkrR7XMmNp3pA3YD/u88GtLzi2G+71iA8Wm9C4eaGCN9iQXBx3t+8lvaMKIzW9uLbjSFS3ojWjR0m/LNjS89Baoas/mpFcFdoI7KvZxO/IBppotthJjMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979327; c=relaxed/simple;
	bh=1gugNpaRDC8T2+V0nHhyhj2FphPga5rNyda7jlSqvtU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KCe0+17MOwyrGflOcfRq7rBQZHP9tbDUfR/gXe+C98fAZkzhz6UsJechZVNzLiEwbdwuwhEDNDcpkd9mYm/DxH+dz3lG/IPP4w0waGlsvuVlkAt890OMye7ohG6MJs6KrSSdMGkr0IhRumh9PBUh6cH3HAPnpCW2Qveb15ZE2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ckTK94i3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSQHX8KT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:48:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756979324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/2ryN3GyHPV8KNT8s59ricwVRMw4mpOEqTWOa5V1Uk=;
	b=ckTK94i3S8yaVXvlVLouf1EpvDf2qYQJosFzC/TrffnJGDQ1B9bZ4Br/9TVEfkkx6B/Gv1
	XCdz+f5eIkivXRu7vXT2cnIJmvvO8w8h+Iacsp3bWwxBPRtj7nE5hDG1DG+YvYfwKUQpau
	g/KZisNkSBTf0bTW5BCuRqh5hdP2LMZGPnlKbbGj4ctkQc9WSgNQlr5C9wd5NjxQwFnKNL
	QPK9Tn2D9S19ug7LxVpnCd7cnG1OVGoTii1sUqwwTsdQRuTybK6AGCThCmyN5zyclwILND
	u2NDKOVz2ukTs0YPPT3u46hK6iMs3GJLIFWysKmcXlkFimycLWHg/Yzchr3+LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756979324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/2ryN3GyHPV8KNT8s59ricwVRMw4mpOEqTWOa5V1Uk=;
	b=NSQHX8KTYNggirRNL4LxKTSm9+O0mDJfOaW7bR8RlCUI1A5mYCCA7Vs4ww/tF+fsBiX7w9
	XLtEQPQdazhV3QCA==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] tools headers: Remove unneeded ignoring of
 warnings in unaligned.h
Cc: Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250722215754.672330-4-irogers@google.com>
References: <20250722215754.672330-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697932270.1920.4290142302700366786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     00b04d1a95f3d33d7269eb2a0d07b2850c473fb5
Gitweb:        https://git.kernel.org/tip/00b04d1a95f3d33d7269eb2a0d07b2850c4=
73fb5
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 22 Jul 2025 14:57:54 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:43:03 +02:00

tools headers: Remove unneeded ignoring of warnings in unaligned.h

Now that get/put_unaligned() use memcpy() the -Wpacked and -Wattributes
warnings don't need disabling anymore.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250722215754.672330-4-irogers@google.com

---
 tools/include/linux/unaligned.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/unaligned.h b/tools/include/linux/unaligned.h
index 395a446..d51ddaf 100644
--- a/tools/include/linux/unaligned.h
+++ b/tools/include/linux/unaligned.h
@@ -6,9 +6,6 @@
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wpacked"
-#pragma GCC diagnostic ignored "-Wattributes"
 #include <vdso/unaligned.h>
=20
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
@@ -143,6 +140,5 @@ static inline u64 get_unaligned_be48(const void *p)
 {
 	return __get_unaligned_be48(p);
 }
-#pragma GCC diagnostic pop
=20
 #endif /* __LINUX_UNALIGNED_H */

