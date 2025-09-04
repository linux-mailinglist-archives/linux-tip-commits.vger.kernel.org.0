Return-Path: <linux-tip-commits+bounces-6484-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429ACB43C4D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D39681B5C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF3302CA2;
	Thu,  4 Sep 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STVqMzCw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dPsVAPft"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B53019CC;
	Thu,  4 Sep 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990709; cv=none; b=YxGxaF0uZHfL+h0iI0HeDFFRypMett9nCfka4axKuQHOINQ3LsjYFU3a6e3FWRKN7x3J2krTcXvEGa/MXzwJITDtSIzuI7B6ZfphNFxGBOZ6ZYJ8P1gHbh5czJiNuAdLEvcKQgITbRo7P7i9QatSvmAXSyXXI8I/bnTkytnTcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990709; c=relaxed/simple;
	bh=ZvydshNF1PkQuxHkxbpBH9PsjfbrGTUyZMko8jAbSwc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FKiyLzWycjZS2r1TJDMptc/c6Q4xJ8X2W+Ppv29ginncoXGOul+FIlwRGxXUFpNXqPLvpgEGsoHtzvyiQWZ0VHK8GJQZfv3Ag1zm1XAY785iKUmL2E8hBrRuhSyqtqxFIzmo4g/NpbPuV0F14zkTkQmE5ZfBZCBRwz5TbIkYuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=STVqMzCw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dPsVAPft; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 12:58:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756990707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4YWdCe9KNw7SD3+s1zDvTsto7IadJ7PJXC7oHQvW4o=;
	b=STVqMzCwnh2+h7QhPC/lzGhgU9VBs+AWlIGynbBI5mjqtPgVNgA35MW25KTpDXev2ZGC69
	y8d/cCH+KzbPw4ms3QZkThsHm8aqpduSoQ1Vk/WAc+AlQMP6qhWjROHMGi8L1xR3sDqA7F
	TYRs75pnwGL/vRAhLappIfJHLLtMLwoC3QQBySMmWAawRYF6PzB1iCH5tIYCZ964ODFvww
	oUbgHwMY2u8NsGg7FK/YPjzZhhF1PFXyQBevm9gqzsfAcWYMKWd1mIswvizqhrhSl8bMW9
	fCH0GrhUPiTTp6CXJKGgWmVoZqUD0ylcCpmqqjYltV8HySPJ97+40SjrO7lvUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756990707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4YWdCe9KNw7SD3+s1zDvTsto7IadJ7PJXC7oHQvW4o=;
	b=dPsVAPft8/Wwv0IdeLRfGyv4bHDZsrhCVa3nx4K1PRIkfF1rTQJwCZGC8pG3FIv5Slf2yq
	qdc8hrMOGOczNxBw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Add struct __kernel_old_timeval forward
 declaration to gettime.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250815-vdso-sparc64-generic-2-v2-1-b5ff80672347@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-1-b5ff80672347@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175699070589.1920.1760011553184382810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e994a4197086cd5df809277b3b96c88f75e1e860
Gitweb:        https://git.kernel.org/tip/e994a4197086cd5df809277b3b96c88f75e=
1e860
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Fri, 15 Aug 2025 12:41:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 14:55:44 +02:00

vdso: Add struct __kernel_old_timeval forward declaration to gettime.h

The prototype of __vdso_gettimeofday() uses this struct.  However
gettime.h's own includes do not provide a definition for it.

Add a forward declaration, similar to other used structs.

Fixes: 42874e4eb35b ("arch: vdso: consolidate gettime prototypes")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250815-vdso-sparc64-generic-2-v2-1-b5ff80=
672347@linutronix.de

---
 include/vdso/gettime.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/gettime.h b/include/vdso/gettime.h
index c50d152..9ac1618 100644
--- a/include/vdso/gettime.h
+++ b/include/vdso/gettime.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
=20
 struct __kernel_timespec;
+struct __kernel_old_timeval;
 struct timezone;
=20
 #if !defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)

