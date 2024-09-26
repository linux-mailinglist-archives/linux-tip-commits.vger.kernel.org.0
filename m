Return-Path: <linux-tip-commits+bounces-2310-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96BE9878C5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Sep 2024 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8A41F24C89
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Sep 2024 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468FE1494AC;
	Thu, 26 Sep 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOnwgZjk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRjS5QTI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FBD535D8;
	Thu, 26 Sep 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373581; cv=none; b=Uyh4FDNGeEyjHF8pQhSNqKOocgs3Ic8/QcQTHqz0JXt/ZBhH7qyhZ92hmjoIPmahQcjfGxma2pkx8vdYdAEyilUkTleUkWmIhQVjk0yP2fEQXMmeiK7PgETup3tpc+pJz4A+pUst2V+BwYywG2sbYcraJ3CQdjq5rfDinrQqKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373581; c=relaxed/simple;
	bh=zFKAp69MtPjHOhx4qLz8Hc7rMi1VESgUH8iYdnI0wbo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FmCkF/A1HYC2TIhIprnhWxGIjuCDnLDahaxiRA0BgNUblwy2V/92kqHojuGCrnKiusuZI6Af5woA5JDBn4eK+0UN81A0HZSQEZUOrsqQ4PJBnL2xnbggTTCZRAi/MxKw16dIFu96ILJ8/dr1xSxVer7irjvSLRFE0sg9R7SSDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOnwgZjk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRjS5QTI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Sep 2024 17:59:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727373577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OLMHCbmlCAKlaos9H4lq0gWWNlKDezffgL2LeRCH6z8=;
	b=UOnwgZjk+p62Olw/biso/OFHv0JJ7zJp5mBwAyytAW0BNG39wjSkf93CYZCoWWHD16lC61
	NR0XGwf0dd9tUH8/c2bbVz8kRI9xr0DMEvv5qdQCMXoa/mDBuDjdJDHU6KtUhI0tQ/Quv2
	qj7jIBbdGiZmkms9skmEHhFUDG+42rCmYyWp/PZQ8uK4jkRGpU10qWrBO6Mn4rnICdhHJY
	TtkjZ62/FqzCdECNZ2Qv6bjBL4gJ3FCMtY+bDfNLP5ojNd+keA+h5VWQ3leL/0sAhrVHTV
	jyu9G221rOBTGD1xsTpEaIcP4QamXrlVKvfSThhon+KgaS27vD7hJZsWJuPMsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727373577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OLMHCbmlCAKlaos9H4lq0gWWNlKDezffgL2LeRCH6z8=;
	b=PRjS5QTIyzsI5I+vKvvvBeWxgKhgiZh7Dp189/ENbPZ1XqdArZaSWLxacGSB/bxVndQCrf
	nWC+KuwmddUBCjCg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add two Intel CPU model numbers
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172737357624.2215.4211392863666172616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d1fb034b75a8a96fcb4bf01a7c0e1421eef833a3
Gitweb:        https://git.kernel.org/tip/d1fb034b75a8a96fcb4bf01a7c0e1421eef833a3
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 23 Sep 2024 10:37:50 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 26 Sep 2024 10:47:49 -07:00

x86/cpu: Add two Intel CPU model numbers

Pantherlake is a mobile CPU. Diamond Rapids next generation Xeon.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240923173750.16874-1-tony.luck%40intel.com
---
 arch/x86/include/asm/intel-family.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f81a851..17d899d 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -191,6 +191,8 @@
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 #define INTEL_LUNARLAKE_M		IFM(6, 0xBD)
 
+#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC)
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
@@ -257,4 +259,7 @@
 #define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
+/* Family 19 */
+#define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */

