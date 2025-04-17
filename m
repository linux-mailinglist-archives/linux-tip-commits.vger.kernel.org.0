Return-Path: <linux-tip-commits+bounces-5051-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0BEA92598
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 20:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0293A9811
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54EE256C9C;
	Thu, 17 Apr 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kS8atxwC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PU5oAnSj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A76257AD1;
	Thu, 17 Apr 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913011; cv=none; b=dYoDJ3rtx9KZQqidPWMtLp6zHN9VABoJAVY+w4H1FQSDL4hiJpYtPL15W235v240I4o7yuXAtX6ZOvsd1jOstCtzcFYyqXyrrmfjuTUyG22R9SXmlS62PxXCcBYhGwtKZSqaMQhexdMfUftqzV2vjvFLlRpQspdV1qMgNXc/1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913011; c=relaxed/simple;
	bh=SHagOM7q8YotFbO/VX8Cd8VQdTdJhrU2B6P3R8m43U0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ryTxE+eTI7uefeo5TTqF2CFmNAqYAgbHvqwKzgWIve1OD51BN8iA4meNwlIEe0v8vNSRVgY1hEVbHcBIf012Lsf40qic7zKDz3f24S3LA7c2byLgbYZsPex+SFQhTWSwqyROIQA21vUKo4pP59rzzm3o8LXCLUWgiAVnp6slwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kS8atxwC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PU5oAnSj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 18:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744913008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vH8JDT/bgq6XEaGBXPCAdqlVPFUvFzuv7efqS6ba+Aw=;
	b=kS8atxwCnXKdsXkNqOFLZPBnr5lIpkwHqjPWSOPEcZDMYG94+aIYk3lACj1YdN0hDxQN+k
	I72rg7QTG8KJ2kSkW6cYv4pYUR6Ogrz6mSMe67Z0/F6txOQr63JZTSRqiMHzRNggUV4DHt
	WGDp0Ou6ikIE4EloZtp3V0t8Z6LcaV3GkrzbTAUqm3D8ftUlkFIuzG4YEYB6gqT2Lvd/dr
	Y0DOk1qnmPpiIaxu0d11izEW09au1Z09YFR86JS8fx0WqT+71/bdAev6um2mBH4ZaxsMHN
	xId/uwLFmvIwPmVc9xYthPIYZpRaRyPtF9waiLrOcYHldsfVoAYKDcztUKamIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744913008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vH8JDT/bgq6XEaGBXPCAdqlVPFUvFzuv7efqS6ba+Aw=;
	b=PU5oAnSjoMwRF6f2fQRqC+UQj4Ogsl+fkmEgXV3Hb8p68sAkQirX384MI8867pl+2pH9lo
	n8dnge7v5MpRD8AA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Always tell core mm to sync kernel mappings
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174491300738.31282.6790702061292691578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     eb9c7f00f22d6ea2a94e00eb4f33a79064681564
Gitweb:        https://git.kernel.org/tip/eb9c7f00f22d6ea2a94e00eb4f33a79064681564
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 14 Apr 2025 10:32:37 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Apr 2025 10:39:25 -07:00

x86/mm: Always tell core mm to sync kernel mappings

Each mm_struct has its own copy of the page tables. When core mm code
makes changes to a copy of the page tables those changes sometimes
need to be synchronized with other mms' copies of the page tables. But
when this synchronization actually needs to happen is highly
architecture and configuration specific.

In cases where kernel PMDs are shared across processes
(SHARED_KERNEL_PMD) the core mm does not itself need to do that
synchronization for kernel PMD changes. The x86 code communicates
this by clearing the PGTBL_PMD_MODIFIED bit cleared in those
configs to avoid expensive synchronization.

The kernel is moving toward never sharing kernel PMDs on 32-bit.
Prepare for that and make 32-bit PAE always set PGTBL_PMD_MODIFIED,
even if there is no modification to synchronize. This obviously adds
some synchronization overhead in cases where the kernel page tables
are being changed.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250414173237.EC790E95%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/pgtable-3level_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 9d5b257..9759fa0 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -29,7 +29,7 @@ typedef union {
 
 #define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
 
-#define ARCH_PAGE_TABLE_SYNC_MASK	(SHARED_KERNEL_PMD ? 0 : PGTBL_PMD_MODIFIED)
+#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
 
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map

