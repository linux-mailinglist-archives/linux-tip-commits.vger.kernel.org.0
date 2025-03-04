Return-Path: <linux-tip-commits+bounces-3844-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF768A4D644
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CFB7A2EA2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC21FBC9C;
	Tue,  4 Mar 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vD6cO9wm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y1AXLZiJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909C1F583F;
	Tue,  4 Mar 2025 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076869; cv=none; b=pJJezkFFaQiBpBGEpJelJKszQ8s5YeNGIJocgKVrfggpzn5YL1Bu4k4Y3LviC5nDVGZFUf4XPIbRxSch9pzBiJGXqPBtgUAyByF4tzv5VW3Tz9ri1HV68UXuSlkazFR8GNn+wnEoTLBfV5R3im9ozJ+MmNPrRpC/tfGwzHlHHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076869; c=relaxed/simple;
	bh=8s9mfSTjGq35hseD13vVNB76BI7vZ1PYjIXWOxCKhUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E46+sH9JAfVQJlJe6l38zrP43yfpWsmAjf16Vt5lNXBtlj6GGh/OR3M8uO6EtXQJ9dlGYZWopiY97Memx8KCohRqKjOgvX1FtVmjOC1MrJqlozu40DpG/Po88451kym1e3qYaagZkbohUhidsIlcP33MOh5/h4XHVldX3Ohjzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vD6cO9wm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y1AXLZiJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRboBk4SHCTRowwtoMhXVJknuO/qqSn/Bp5SdhLxiqM=;
	b=vD6cO9wmg61ma7zwibcizBsH2StD1LZsugjnQ4pRUt1WxiY0jUnW6108rddqhyInSwbZvk
	I9Kb5uyoiJKqlVHS2mOXiF6bekx3+mgibyUuIIC/NshzhEPAhdliQ8dAUXcwwMNXEyUCMs
	Ewcu/LgGGi2KcTr9kToWgjLeFVIZHfx+i/ainvzP4u2w1QsR6fQpl8ixPNqw/kclJrwn1Q
	CPnm8Zzj7XxcqIjFnERO4yTnZHe9LHfW8hWNF7H71OSYr0Px4ezVFTGCI7rwIqh2+jj+Po
	r9BBteoL9j/i8XAl+Tc1bXYjC+8NfRwH3Z4fZe495dQQGMmLQYN70BbC9Kchaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRboBk4SHCTRowwtoMhXVJknuO/qqSn/Bp5SdhLxiqM=;
	b=y1AXLZiJqm5uaByrRXn+SXYE2GpITmz1K2EK7F7LD8aJObGCuscRvoi8xk6tyh9aVFigaj
	cGgNMBR9s4rY5bDA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Move this_cpu_off to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-12-brgerst@gmail.com>
References: <20250303165246.2175811-12-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107686201.14745.11976222982822439246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     cfe31c859a8123a282e0ecee76bf77fdc3bccf74
Gitweb:        https://git.kernel.org/tip/cfe31c859a8123a282e0ecee76bf77fdc3bccf74
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:46 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:37:41 +01:00

x86/smp: Move this_cpu_off to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-12-brgerst@gmail.com
---
 arch/x86/include/asm/percpu.h  | 2 +-
 arch/x86/kernel/setup_percpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 6fbb52a..4f202cd 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -584,7 +584,7 @@ do {									\
 #include <asm-generic/percpu.h>
 
 /* We can use this directly for local CPU (faster). */
-DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 175afc3..bfa48e7 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,7 +26,7 @@
 DEFINE_PER_CPU_CACHE_HOT(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
 unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;

