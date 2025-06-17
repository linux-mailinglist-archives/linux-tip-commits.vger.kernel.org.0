Return-Path: <linux-tip-commits+bounces-5861-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BCFADDFCD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 01:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3D5164B76
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9421F290D97;
	Tue, 17 Jun 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j4nimZRC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/3p8W43z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBE28BABE;
	Tue, 17 Jun 2025 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203841; cv=none; b=g2Kx1wTO+gGU2C8KYLfd5yOYE5UFG9VR/inmaRV3SiDqOVx1SmzMZ+Qxm7aN5hMQKSnsvcKHXWjehJ5Csd6wHJ+IAhcSWqDy85krQP//CI6cVzR+3HRUbvx2mjNhuzqP/t7lnbLNBfZsVnMByT3Lf8evWo8hkouT8Ip+P80olx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203841; c=relaxed/simple;
	bh=5gaIYMyWEGPDDJ0tEIlajFkJ7otHdg6NLtkNht4GYh8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dyZiaabIYVrqX5YbLYfU3hdjwJQDaitFtJQiKIURGgJxAYlGCc9+ll7sSl08vhGTZsTXg5/YRK9XTuTci8tpxX/WGW0TH2XpXm3ccRMG6wQXkT3K/nsZHPqxc583YLziDltY/KutwsZ0Y4prZux8HJsK3m2rHU4kx0Ozi3bnXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j4nimZRC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/3p8W43z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 23:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750203837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2WfbRvSQu/LvaRuye2VzAsvDCLn/QC9hVuSuczM+SI0=;
	b=j4nimZRCHxqO6koZVcotObZvJ5UMPJB8IFsO9Fdfx7x0PAk92Wbc43mnd9y3EWBJS5lbtR
	3p7dMvTSaEn9KNYOhSsBMQLuqeNN/ZePCTsRM2lkOqnwoXhWGml0nwKkcsYyTTjxK8LgDA
	zyVRBo1mP8qAaTgzxWSY39g6KxCnhEdOxQBiEDAI3WoPZycAGWd75HJpn3yfjOsX9VtBvb
	2Kl2XkDieTZzaobp6eDi9QIDlz3Am5LjfoE8qOwulVpViypcm1p7s/m7i9AjNGtBXUfubL
	DhbFoTF4iXmuHgwBeHsONPZ33WcsOoY3KM1HFqYtF98YDvbxAutzs3k9N2m4YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750203837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2WfbRvSQu/LvaRuye2VzAsvDCLn/QC9hVuSuczM+SI0=;
	b=/3p8W43zWnaHXPoQ65YCat0A3olP63VbAYFZqDqarhcR2+6zfGkUG9Gsp4iwtJ3TGMAOYU
	7Hvx393enZjcsfBA==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix early boot use of INVPLGB
Cc: Rik van Riel <riel@surriel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175020383660.406.12562669775313990568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cb6075bc62dc6a9cd7ab3572758685fdf78e3e20
Gitweb:        https://git.kernel.org/tip/cb6075bc62dc6a9cd7ab3572758685fdf78e3e20
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Fri, 06 Jun 2025 13:10:34 -04:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 17 Jun 2025 16:36:58 -07:00

x86/mm: Fix early boot use of INVPLGB

The INVLPGB instruction has limits on how many pages it can invalidate
at once. That limit is enumerated in CPUID, read by the kernel, and
stored in 'invpgb_count_max'. Ranged invalidation, like
invlpgb_kernel_range_flush() break up their invalidations so
that they do not exceed the limit.

However, early boot code currently attempts to do ranged
invalidation before populating 'invlpgb_count_max'. There is a
for loop which is basically:

	for (...; addr < end; addr += invlpgb_count_max*PAGE_SIZE)

If invlpgb_kernel_range_flush is called before the kernel has read
the value of invlpgb_count_max from the hardware, the normally
bounded loop can become an infinite loop if invlpgb_count_max is
initialized to zero.

Fix that issue by initializing invlpgb_count_max to 1.

This way INVPLGB at early boot time will be a little bit slower
than normal (with initialized invplgb_count_max), and not an
instant hang at bootup time.

Fixes: b7aa05cbdc52 ("x86/mm: Add INVLPGB support code")
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250606171112.4013261-3-riel%40surriel.com
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 93da466..b2ad8d1 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -31,7 +31,7 @@
 
 #include "cpu.h"
 
-u16 invlpgb_count_max __ro_after_init;
+u16 invlpgb_count_max __ro_after_init = 1;
 
 static inline int rdmsrq_amd_safe(unsigned msr, u64 *p)
 {

