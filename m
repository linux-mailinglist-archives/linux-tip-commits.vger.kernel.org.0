Return-Path: <linux-tip-commits+bounces-3701-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807DBA47A80
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C19189061A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5822A1EC;
	Thu, 27 Feb 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FX/8b6Ri";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gfRWGEKB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327A22689C;
	Thu, 27 Feb 2025 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652934; cv=none; b=iI9HBft8IAyJKOwnFehT9BTLVh/AXxF33Z6lektPvNrFiI+2c4VlXi+tXGesb0nzcX/GxCe1OTOUuoNobaRPxgHwDgb9WUkrMMCSFcdEnnPjTFfJ6THlqpdEiJtOBCGxVd1l5W9+d6bjzlei/uTxCZmCMhVmHp43C5Y3qw0cAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652934; c=relaxed/simple;
	bh=nm88BKYtxUlLzh777GJzHj76kgv/QcyKMEWBGAVZhTk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EkrVKJYylYId0pBXXO6WEgditBYxI2WKzbV1r4kphnxlfa4mlhSnpnf0fZyKeh6o85Ac+XRMM0IekdltC/KZIjxX+2FG3t7IzhIM/TAouZfckNZZnqFfea84xC+sxVfCUZioGIo+CVNoe2nHxcGmxpCotTSL7BdnD88Y7oXUhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FX/8b6Ri; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gfRWGEKB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SORaws+keb0b10VeP6oZvKm/X+VkQEadjJgBi5duzm0=;
	b=FX/8b6RiQIRp8R3HxcnjtrDWAFClOFe4NkRjmYPsHZTffgZovCqICwb87aDK2hYWzfvSnu
	H3BGcmRJ+OtfI2CjpcS1qoFOx5dmE86CKJiM86aEGE14BOVvCHA81S/dicOuTo5O/GMDXm
	yw3YfkZWZi4tqrARuH1ZBBHo+VzONAEl0cJ8Wk08yhAS2sOE6iqJ4TwtxTTF9WCN5cczj9
	hMKwWQzhs8gd+V6hnHlXU/TjYv+XAokBYPKnLxWTxgNjML/2NG/zW+aTxkqN552tNsqCF8
	Kh7PORr+9HLTbFZjNjdcL1SM0G99N3M/GjoW+QQtK2imbS7KigLH7B9DrCsbMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SORaws+keb0b10VeP6oZvKm/X+VkQEadjJgBi5duzm0=;
	b=gfRWGEKBXqrvK+V7jWD6RDARw7hPgaRNgek+61ovdOA2sb8otOUEeqqufqcBKEyOJrF8PN
	uMt947vaKmrmvoCg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/platform: Only allow CONFIG_EISA for 32-bit
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-11-arnd@kernel.org>
References: <20250226213714.4040853-11-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065292696.10177.7788333309494763418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     976ba8da2f3c2f1e997f4f620da83ae65c0e3728
Gitweb:        https://git.kernel.org/tip/976ba8da2f3c2f1e997f4f620da83ae65c0e3728
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:22:16 +01:00

x86/platform: Only allow CONFIG_EISA for 32-bit

The CONFIG_EISA menu was cleaned up in 2018, but this inadvertently
brought the option back on 64-bit machines: ISA remains guarded by
a CONFIG_X86_32 check, but EISA no longer depends on ISA.

The last Intel machines ith EISA support used a 82375EB PCI/EISA bridge
from 1993 that could be paired with the 440FX chipset on early Pentium-II
CPUs, long before the first x86-64 products.

Fixes: 6630a8e50105 ("eisa: consolidate EISA Kconfig entry in drivers/eisa")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-11-arnd@kernel.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 383b145..aa90f03 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -233,7 +233,7 @@ config X86
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_EISA
+	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE

