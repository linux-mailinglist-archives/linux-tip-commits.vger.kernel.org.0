Return-Path: <linux-tip-commits+bounces-3957-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D0A4ECA0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA16F167472
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A524EA9B;
	Tue,  4 Mar 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IehZU5d0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/c0PDdGs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550424EA9A;
	Tue,  4 Mar 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115007; cv=none; b=Lj+0xfwKezI5a2My9Ok+sRE9u8IJ2/5sIERUKaAbgWl+qt7/drOMUZrvJoDcQdRvXzVLWQvlGhCjDbLPJmMgNmyL2/IqpElRDnr+NKoFXY2+/4vTQy7VHl72O8Z8TYkiB5Ade3ectfuOoxKWzE18NuTLS2y/1ZACMSy67emwzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115007; c=relaxed/simple;
	bh=CPELXozTeReH2ofb9KpESsg9LYa/ImFn14grBac7rT8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rnLJfwi1Bvb1haguLXm3l+qegvcR63qhV4IQ3lrfO3JDPYXyex80aUr90Du8uNDnh2Tbb8h79MKAUstqNDsIeAJ7xFev5QpjQ32wqtGbCTUJpJKFzhzhb6VB64/qrcEYvkGlW3UAT5zsG0i8Xl+kM1NVoLhSscWUAGbJe1uk0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IehZU5d0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/c0PDdGs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741114998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoRjfGENlhPI/bFhwdClDqShNTuAMaGgnOC3/ni2/CY=;
	b=IehZU5d0g+9PteRPD6H/meJhNUKFmp0rPjLDFUBIhw2s6SAb0R9t2ukh8N5YPx3E+nHq7r
	gHsicOVuA6sWtkCW8sZrwnD+bw01hjRDL1PlRICPHm4j+zvHEfYglLQ4Kqi/dKyjIWCLke
	b8bAIdBU/vy8kLMY6zOwnDgY6XOy2U6N7AZi2atcZZWY5bSS7lR/2ihj4cqlNl8w95LHUW
	DaYq38PYrl/toHT/Ew0TvqAf7guGegNwIlF1KcknoiQCGIJE0INbcP5YJWCXoxzpwno0PQ
	WZRsa43f0ULjKe46CyWnJJwyK2nbwByXlHkS5vHyU6BoBbBSlPBpdXgarSwOZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741114998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoRjfGENlhPI/bFhwdClDqShNTuAMaGgnOC3/ni2/CY=;
	b=/c0PDdGst86HeJodB2S/VHbgaTAl4Rnw2SdQbFhIk2b96FR7FMK62tfhAbzn2JTbQF1//0
	H4BL0bdyrwq9jmCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Fix __per_cpu_hot_end marker
Cc: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Brian Gerst <brgerst@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304173455.89361-1-ubizjak@gmail.com>
References: <20250304173455.89361-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111499551.14745.17175153879841115008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     56cbc77dd94dc4932dd4d4543bd92a3334815354
Gitweb:        https://git.kernel.org/tip/56cbc77dd94dc4932dd4d4543bd92a3334815354
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 04 Mar 2025 18:34:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 19:54:26 +01:00

x86/percpu: Fix __per_cpu_hot_end marker

Make __per_cpu_hot_end marker point to the end of the percpu cache
hot data, not to the end of the percpu cache hot section.

This fixes CONFIG_MPENTIUM4 case where X86_L1_CACHE_SHIFT
is set to 7 (128 bytes).

Also update assert message accordingly.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Link: https://lore.kernel.org/r/20250304173455.89361-1-ubizjak@gmail.com

Closes: https://lore.kernel.org/lkml/Z8a-NVJs-pm5W-mG@gmail.com/
---
 arch/x86/kernel/vmlinux.lds.S     | 2 +-
 include/asm-generic/vmlinux.lds.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 31f9102..ccdc45e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -331,7 +331,7 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
-	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
+	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot data too large")
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c4e8fac..4925441 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1072,9 +1072,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(cacheline);						\
 	__per_cpu_hot_start = .;					\
 	*(SORT_BY_ALIGNMENT(.data..percpu..hot.*))			\
-	__per_cpu_hot_pad = .;						\
-	. = ALIGN(cacheline);						\
 	__per_cpu_hot_end = .;						\
+	. = ALIGN(cacheline);						\
 	*(.data..percpu..read_mostly)					\
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\

