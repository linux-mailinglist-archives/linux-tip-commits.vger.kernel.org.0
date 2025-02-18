Return-Path: <linux-tip-commits+bounces-3503-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB99A39BD8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7753A4D02
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5052417CE;
	Tue, 18 Feb 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpm1DKZt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQIFp9FK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632692417C4;
	Tue, 18 Feb 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880705; cv=none; b=ov33+Ze1KEG++Gz7smeuTygD+WOlnxn1cN003AgxU8qKRqvzeRFPY5k0q2yuxnCEND0MbNvf9VqNJqEtbjXV5sjyaNasL/IXXzrFnfLGksNnLZwV7tNLIlO5RiSnbbncF6tDNlDNhdPzrVKvah8Pt2fxhb/+9jLX8Z6xtZqbxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880705; c=relaxed/simple;
	bh=OuGiI++RXsS7HYUC8E7BKbFq70Bf7x1XvmGoLc9pARg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=encXcTGZHs6hL9Imy+DEevYJGPDnSLYWiZ+gmCWxkvln3csOLz1CUNczMT3T1wPcxwQ9ZkMS8S40k+RqvXQ9Tue3kJif/lHGvEWafgwJAur1uFIuz+rk+wOsXPMcrD1zsm81/TtNBM9kS4RCI32QnpUE+ZogI1ASKPUdWtqRJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpm1DKZt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQIFp9FK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPl+ciPC6dDvZYoJGuY+3RpzaC+O2XqL9lJ6skUOJE8=;
	b=cpm1DKZt4DYep9ekdl0AT1I/6UdZXP+j7vBBzCIsR9cxAE8+bPLXe2p8dTNzWFxrUGaVsQ
	Rhte9bxXG9GksFLQsNUq4Dl2yDGXElUF7D0tAi3ndaymG2x4aySpR52cVk5EcaExuDkeOU
	QOLAGG+7mn8CvDDssZ2ZYCNXf2Fzlpi0GRIuATcGcqBCNJISWWp7e/vHbl89/fNWSPYpxq
	bsmNTKkn8C1JDgnRpeg83JNbi3bKBZ6jBBWng1Ehwx3fcLQX2ifgm17EUDFgLYUYZYd/MT
	McqI+UdNmqGb6hFd0Yt0cmz6bL4ZJH04blKHNcDsRTDHAn0VhQBn1pffn5jSdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPl+ciPC6dDvZYoJGuY+3RpzaC+O2XqL9lJ6skUOJE8=;
	b=lQIFp9FKxGXYSNo9hZ+Un+lauGFjw6/82MKJavy0yF9dXwNsepL/DFOsYExZ9v4el2VONF
	3X76pQgnY7YzvfAA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] percpu: Remove __per_cpu_load
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-15-brgerst@gmail.com>
References: <20250123190747.745588-15-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988070155.10177.14180175740153097816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     4b00c1160a13d8bf7297ebf49ec07a84e1f41132
Gitweb:        https://git.kernel.org/tip/4b00c1160a13d8bf7297ebf49ec07a84e1f41132
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:46 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:16:00 +01:00

percpu: Remove __per_cpu_load

__per_cpu_load is now always equal to __per_cpu_start.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-15-brgerst@gmail.com
---
 include/asm-generic/sections.h    | 2 +-
 include/asm-generic/vmlinux.lds.h | 1 -
 mm/percpu.c                       | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index c768de6..0755bc3 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -39,7 +39,7 @@ extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
 extern char __start_ro_after_init[], __end_ro_after_init[];
 extern char _end[];
-extern char __per_cpu_load[], __per_cpu_start[], __per_cpu_end[];
+extern char __per_cpu_start[], __per_cpu_end[];
 extern char __kprobes_text_start[], __kprobes_text_end[];
 extern char __entry_text_start[], __entry_text_end[];
 extern char __start_rodata[], __end_rodata[];
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e25a8ae..92fc06f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1084,7 +1084,6 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
 	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
-		__per_cpu_load = .;					\
 		PERCPU_INPUT(cacheline)					\
 	}
 
diff --git a/mm/percpu.c b/mm/percpu.c
index ac61e3f..7b58353 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3071,7 +3071,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 				continue;
 			}
 			/* copy and return the unused part */
-			memcpy(ptr, __per_cpu_load, ai->static_size);
+			memcpy(ptr, __per_cpu_start, ai->static_size);
 			pcpu_fc_free(ptr + size_sum, ai->unit_size - size_sum);
 		}
 	}
@@ -3240,7 +3240,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t 
 		flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
 
 		/* copy static data */
-		memcpy((void *)unit_addr, __per_cpu_load, ai->static_size);
+		memcpy((void *)unit_addr, __per_cpu_start, ai->static_size);
 	}
 
 	/* we're ready, commit */

