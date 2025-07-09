Return-Path: <linux-tip-commits+bounces-6053-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF2AFEC81
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 16:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2BF642976
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320D2E6104;
	Wed,  9 Jul 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X4jZRfji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/3gsdEh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD642E5419;
	Wed,  9 Jul 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072493; cv=none; b=nN+lTLW/pXqc68KpfrIhDaUO6nO9lYwX4sWQMMwMR85jrsh/TJWB44RW78OFFsT2S7wOgDa8WxkTUMLW6EvV+bCy63PXp5WHdkqSHicab4RKee6FPJWR3/MiQwUFyl2HK3oFJ+cW5YaaZnXvqK9CWN5/bhTW+IYL+fz54TGmtng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072493; c=relaxed/simple;
	bh=FXn1L6gasmUY/obvXlJMoAqMi0aHoavGZg8CePT2+7Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=RHVDwpvCb5PWb0rvt3bF/YqNW/x6e/L1FkZIPUcMfesOD3yRx7BqnTx41UR2b1v2pgaQSLrASR9/t3D26UlGafPSUGJFtmOe10c0CplW0paVTkNzC9DcqCghVnrcO1l4Pa2WXxzadmvuFRYGxZrb53GANvlXqq7CyZxWDbHFwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X4jZRfji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/3gsdEh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 14:48:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752072490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LJcPrD6R/0szDi2tFZoFKNctrjdOaIxGYk6o5dTlDaI=;
	b=X4jZRfjiR09GGtqAoEYjbNWXKJy79up/HzWYOJ3fBBJau5qXbJGUDGSQq8/O+UwVp5hIRS
	uyfSv9bi3TXByrODzWUMGyiCwuaRtKBIOa6PNJvWRFTVXV8cVj7J1rJGBs8lt5H0xjQVBi
	VVT8iW+Vh5bttJo/gKYdEs43ct8TiD+cx43yE7YI6iwIds3zHBFaNUbVWVVRsFIBP0o66l
	mwTa1Rlk0as1hbasCJaUao5jiZXLuz3h0arZOTqwHJrMAc1vyjr3FAH/KiaV5U/uvgs/Yj
	cnSlRCA6wMbJd95UqCZTVS4HBeIaK4SUWYpuOqf5thOa7LBwgcKM2cG2itvlIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752072490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LJcPrD6R/0szDi2tFZoFKNctrjdOaIxGYk6o5dTlDaI=;
	b=o/3gsdEhvN/xNCO64C2RrkmfNYsP9kdWYQreDfp0skzIoYVAuNllt3fNit9FTgiHplJXQZ
	KVkGy3QRTtgcdLDg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] MAINTAINERS: Add Rick Edgecombe as a TDX reviewer
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175207248920.406.13680173640646677552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     f6ed3a2f54bcc4fadd8a003d36513a56b4a5545b
Gitweb:        https://git.kernel.org/tip/f6ed3a2f54bcc4fadd8a003d36513a56b4a5545b
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 08 Jul 2025 13:19:21 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Jul 2025 07:39:53 -07:00

MAINTAINERS: Add Rick Edgecombe as a TDX reviewer

Rick worked extensively to enable TDX in KVM. He will continue to work
on TDX and should be involved in discussions regarding TDX.

Add Rick as a TDX reviewer.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250708101922.50560-3-kirill.shutemov%40linux.intel.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41f627..48f0662 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26946,6 +26946,7 @@ F:	arch/x86/kernel/unwind_*.c
 X86 TRUST DOMAIN EXTENSIONS (TDX)
 M:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
 R:	Dave Hansen <dave.hansen@linux.intel.com>
+R:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 L:	x86@kernel.org
 L:	linux-coco@lists.linux.dev
 S:	Supported

