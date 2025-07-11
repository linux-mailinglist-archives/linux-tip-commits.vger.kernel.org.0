Return-Path: <linux-tip-commits+bounces-6074-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0260B01F24
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2110A7ADEA5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410E2E8DEB;
	Fri, 11 Jul 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LiHKiImw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dppXjgmq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4022E7BD4;
	Fri, 11 Jul 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244210; cv=none; b=c0krh1uYi2z5pUKjSL08VZYFNZAnzgKHkCf8g77N5QPB9pAIxDxVdO7+L6R8A9nBLHZc1PEaGNFxvlawNm34izkwYoHqowRtZKRPzAAtM+dL0NgOc8guKeGNDmipNrr36eJyuu9ReyI2tz5rgTtcaoBiXMr6F+VYKEj13G2g3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244210; c=relaxed/simple;
	bh=DSP3xGgf+ir8sBOisDY5BOckslUjjNmZXJ36vYGphfw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=euJ+R8rcD1qsC12xNFHHmOmNVmXpPBBQq6AHfWG21Vdx/HkmBs7Nxo51wL80Ob7KTqB6zRn3xoDiykgkIe5eEVubOyct8FQwUd773kkVA9IDEtzILVpZkX5ZRAHe19RH55ZvY2YRN0AT1haqgcjxve9L7SbJQItQ0QJhhpDYct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LiHKiImw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dppXjgmq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 14:30:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752244206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vKMpXIBWRL+5xFFYJVlqgClswTODxmHM5+6CRGR/95c=;
	b=LiHKiImwn8vbH2A5gvflwSVIp57JRKIH7CHGH2JTRjHackhPiMGRH03BSBmu74pGykoGR9
	fLexz3IBx+o7ibmVqILpn3D4Xbgapf1N9bZuTQsXQeSgdidWxQkeLx+BNzgRXL/ZIuzhuL
	pchGuhWpNqPuOisEC+B9LAt6dK7i2u50UpjeTczdUPOgMtn/3cSu5N6507yeqMVzOEezTd
	8Brz39CdUwQ9te6noFmmMfsKFCoZzEpaiyi0Kb4JLxpypODJsfs0u48DBjnAdEwk/0kOTO
	7iLOAJgX5VGBnFV8wP2GbJ16vDbTNno7JdDSR8gtWMtTZLLOBeEMl6jA274vIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752244206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vKMpXIBWRL+5xFFYJVlqgClswTODxmHM5+6CRGR/95c=;
	b=dppXjgmqV+IPBivwNoyZvYI/b5ZobeHUwpFmbyOf9PJHetBY52FFedhr69oMDxSNAOYo53
	kl4pc/Cm/oiJQNCA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] MAINTAINERS: Update Kirill Shutemov's email address for TDX
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175224420551.406.7275126393888591351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cb73e53f7c0700285d743e7afbe37cba9f7df8f3
Gitweb:        https://git.kernel.org/tip/cb73e53f7c0700285d743e7afbe37cba9f7df8f3
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 08 Jul 2025 13:19:22 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Jul 2025 07:25:51 -07:00

MAINTAINERS: Update Kirill Shutemov's email address for TDX

Update MAINTAINERS to use my @kernel.org email address.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250708101922.50560-4-kirill.shutemov%40linux.intel.com
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index b0ace71..85ad46d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -416,6 +416,7 @@ Kenneth W Chen <kenneth.w.chen@intel.com>
 Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
 Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
 Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
+Kirill A. Shutemov <kas@kernel.org> <kirill.shutemov@linux.intel.com>
 Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
 Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@linaro.org>
 Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@somainline.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb0..adaf349 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26944,7 +26944,7 @@ F:	arch/x86/kernel/stacktrace.c
 F:	arch/x86/kernel/unwind_*.c
 
 X86 TRUST DOMAIN EXTENSIONS (TDX)
-M:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+M:	Kirill A. Shutemov <kas@kernel.org>
 R:	Dave Hansen <dave.hansen@linux.intel.com>
 L:	x86@kernel.org
 L:	linux-coco@lists.linux.dev

