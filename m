Return-Path: <linux-tip-commits+bounces-6068-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49FB005A6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EC07601CF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE331274FED;
	Thu, 10 Jul 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EaqJmgGX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iyuDNQeq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707E274B59;
	Thu, 10 Jul 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158872; cv=none; b=FLF8hY44WBQllOCQl3ui5Kd9F1nzmusdS2daCB3pS/hvC8OtLQZqdX8wnQ1JJHbEPgMpe/117rL8WyFfHo/qUw3g+CYAHQJODjX1r8kHplhVrxwDHw12oy7M2CSeo6iut/f3xqAowRr9hdWmbF7VNpKfuAJpCL4FkuU05RcA+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158872; c=relaxed/simple;
	bh=bJONfWLKlU4tJ3rMkny4EI76yQ/pad5NOrCrVufno7Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NjADv3i0Xr3JVXv0ZN1UwmXIF0LhX2XXnCigTUA7OF1iaxRXLO3z9sO4s6Oe5gAz1VdcUfTo6P7zW1h7oWpDv/uA2Hblh6U3JIlPgwO7AFp/C2YROrw6Yg4jRlLCSPLDokSafGs0XDu9idcJbqkG40+N1qR3F5ki/P2giIMV9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EaqJmgGX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iyuDNQeq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 14:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752158869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyNG/21XLLAW02Y2kxv/2oVOhDZbbV/hicbW7EyFPuE=;
	b=EaqJmgGX6QYvhySZceYAh9xZeVTSN7OUGRy7NZhcYME/VBBbp2JOAq7Y4DOX//EnP9R1i3
	kRIeBfsBE7VgxjCHRie+/wqPypWAJLfCJDxV35FPM+8bXhPUc08+0CXi9cfTG+O6RHiSMB
	cKs54sVgWvDpwK2fLAKyuCRKDgeK8yKKs9rJNg5tTNJoiUdMul4xklmX3zoo/TtJIW53ab
	alq1Hy658ShYP+39Q6qNYStgaaq8J4tZkLvwrrwR8ZpKyuSPmHjq7pRvVBCqwkFBHmEG3y
	024wWozAs5DWbJJrOaFvanImYfFNtutyiMCNhNHZovNERjmB6fHW0nPI599A8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752158869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyNG/21XLLAW02Y2kxv/2oVOhDZbbV/hicbW7EyFPuE=;
	b=iyuDNQeqcYlyX7xRf4511FLdzwwzFWxnAwW3OMA6YO27ZHKoupTWGsU5OVjsKJ0Cg0MLxD
	fjAItPk1W55FCpCw==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/lib: Drop the unused return value from
 wbinvd_on_all_cpus()
Cc: Sean Christopherson <seanjc@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250522233733.3176144-3-seanjc@google.com>
References: <20250522233733.3176144-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215886795.406.16798831540708958954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e638081751a292560a8aed36ec72e8f65b057892
Gitweb:        https://git.kernel.org/tip/e638081751a292560a8aed36ec72e8f65b057892
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 22 May 2025 16:37:26 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Jul 2025 13:13:26 +02:00

x86/lib: Drop the unused return value from wbinvd_on_all_cpus()

Drop wbinvd_on_all_cpus()'s return value; both the "real" version and the
stub always return '0', and none of the callers check the return.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250522233733.3176144-3-seanjc@google.com
---
 arch/x86/include/asm/smp.h | 5 ++---
 arch/x86/lib/cache-smp.c   | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 0c1c680..028f126 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -112,7 +112,7 @@ void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
-int wbinvd_on_all_cpus(void);
+void wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
 void __noreturn mwait_play_dead(unsigned int eax_hint);
@@ -148,10 +148,9 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
-static inline int wbinvd_on_all_cpus(void)
+static inline void wbinvd_on_all_cpus(void)
 {
 	wbinvd();
-	return 0;
 }
 
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 7af743b..079c3f3 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -14,9 +14,8 @@ void wbinvd_on_cpu(int cpu)
 }
 EXPORT_SYMBOL(wbinvd_on_cpu);
 
-int wbinvd_on_all_cpus(void)
+void wbinvd_on_all_cpus(void)
 {
 	on_each_cpu(__wbinvd, NULL, 1);
-	return 0;
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);

