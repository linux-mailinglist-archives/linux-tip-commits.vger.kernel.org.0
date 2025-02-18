Return-Path: <linux-tip-commits+bounces-3504-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511EBA39BC9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181A717182D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155BE2417D4;
	Tue, 18 Feb 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Twyjj9Cx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6+rjNADt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631EE2417C0;
	Tue, 18 Feb 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880706; cv=none; b=CBjhPJgttqyOcEiBbht4Kp+WX+Xw3/QAbbJou3i5GxJER08X62XX2wukA0dLu3nX4jyBkp1S8ANqLeW7IrJ53AnDLXZQqPOTZoUNbmEkg/aEkKST9hkVcVRHdmWGW2/S2TVPKhsbGtnXdEJe8AX8vWZzzXQjMY6wE8hcWH29oxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880706; c=relaxed/simple;
	bh=UR298nO+ESyHOJ8pUrJkkcUeOzSUvKVQC5nSZUAyS6o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XJX4+AyLB82U2gkXmfLpFOl+smMiF1AAtHxdiNN5Dwthj92uXK4ifcLYIpXtMPY+VGE31Hv8dPKjpnNb1A3cTM2BeW4VfWRrOVwxwoYaNGGcQRN0EPQ2VEz1RIihuyFtGr2gh4386iaqNWJ9mhQSTTBCOrM8+OslOxvX3yACnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Twyjj9Cx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6+rjNADt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8Rw79MOz7CNBGbouOxi/vWsRUf6KHIy0nWf9FbaTqk=;
	b=Twyjj9CxIT+O8QmM/xb+QXpZWalNdwbCOyqu1UPzdEDAJqz7l0WNi/89+GqdLhySmljlBU
	IRCV52fODss1F/2LxDUzvn6AJc4n06tUvrwwBsYFxHYc/RpUrAF1O8WCt/CeA6sLzcNS2O
	I2lxF0wt5zSCYqDw8/VdLDy8novTUcPEpst65OmeRVdHjCRoKJrpt+rKQe6qlNsp/vWlkk
	pbx06BmU1bOf9iDgU+Mmddbrz0LvVROAzDf4G7JQV2e50lE8mjSxJsQzxREta47gO94hKU
	cSzm5UfGiL0WanPw9d+zOyc1qYDEFtILKVL0OXIQ0SbTzyWpl3pJmlK/f6bwdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8Rw79MOz7CNBGbouOxi/vWsRUf6KHIy0nWf9FbaTqk=;
	b=6+rjNADtlEQWkbV1BrFVirXR1izuCcA2ZKQDJKlQV8/Sm1v5DiYXBM4L2r9ME3/tuc6mee
	xK3mEkO4RQpEnSAA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] percpu: Remove PERCPU_VADDR()
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-14-brgerst@gmail.com>
References: <20250123190747.745588-14-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988070223.10177.2653399642759835440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     e23cff6861781ac4e15de6c7bf2d2a0b79cb52ef
Gitweb:        https://git.kernel.org/tip/e23cff6861781ac4e15de6c7bf2d2a0b79cb52ef
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:45 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:15:57 +01:00

percpu: Remove PERCPU_VADDR()

x86-64 was the last user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-14-brgerst@gmail.com
---
 include/asm-generic/vmlinux.lds.h | 36 +------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index a3c77a1..e25a8ae 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1073,47 +1073,13 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	__per_cpu_end = .;
 
 /**
- * PERCPU_VADDR - define output section for percpu area
+ * PERCPU_SECTION - define output section for percpu area
  * @cacheline: cacheline size
- * @vaddr: explicit base address (optional)
- * @phdr: destination PHDR (optional)
  *
  * Macro which expands to output section for percpu area.
  *
  * @cacheline is used to align subsections to avoid false cacheline
  * sharing between subsections for different purposes.
- *
- * If @vaddr is not blank, it specifies explicit base address and all
- * percpu symbols will be offset from the given address.  If blank,
- * @vaddr always equals @laddr + LOAD_OFFSET.
- *
- * @phdr defines the output PHDR to use if not blank.  Be warned that
- * output PHDR is sticky.  If @phdr is specified, the next output
- * section in the linker script will go there too.  @phdr should have
- * a leading colon.
- *
- * Note that this macros defines __per_cpu_load as an absolute symbol.
- * If there is no need to put the percpu section at a predetermined
- * address, use PERCPU_SECTION.
- */
-#define PERCPU_VADDR(cacheline, vaddr, phdr)				\
-	__per_cpu_load = .;						\
-	.data..percpu vaddr : AT(__per_cpu_load - LOAD_OFFSET) {	\
-		PERCPU_INPUT(cacheline)					\
-	} phdr								\
-	. = __per_cpu_load + SIZEOF(.data..percpu);
-
-/**
- * PERCPU_SECTION - define output section for percpu area, simple version
- * @cacheline: cacheline size
- *
- * Align to PAGE_SIZE and outputs output section for percpu area.  This
- * macro doesn't manipulate @vaddr or @phdr and __per_cpu_load and
- * __per_cpu_start will be identical.
- *
- * This macro is equivalent to ALIGN(PAGE_SIZE); PERCPU_VADDR(@cacheline,,)
- * except that __per_cpu_load is defined as a relative symbol against
- * .data..percpu which is required for relocatable x86_32 configuration.
  */
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\

