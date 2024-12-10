Return-Path: <linux-tip-commits+bounces-3048-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EBF9EB70C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21BB161F76
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E51FD7BB;
	Tue, 10 Dec 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nh5qNTog";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cl8sSAvu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845891A76AC;
	Tue, 10 Dec 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849476; cv=none; b=baOCJ3c+TPEQu7YD069ZZ45Tl8keKFUJ5UlVwJFuagbL22WLsffG9tCXAj1dzGhSth4yxaeIfEWkPGx9Xfmp36xUsQ7XJ3QaiLyUwBXsAtU/87nSJ/Bz8Jeom9XOh9kwKdhZC2nBn0brblCI2onmr4wx79KG66fOBSHNZXvc8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849476; c=relaxed/simple;
	bh=XUSw5ErftGVnkYxycjYcl8gbHEMhDCXoMiFW5DrxtNA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KiXcmG/fZdOqITou/UIAm+ZGDvSPWHl3KrD1kPaJzSZLmsgEmgQM6uIQFE8U2EnznTDJGkqUD2+PfWnvUBnnyOSULq+1oYMGFbnZuIpO3m3oc1kEOBUGOtP0abhmQU4PGkjEx6MvIVyaBc2WoqYArbx4FObUaG5CePRECMGTpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nh5qNTog; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cl8sSAvu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Dec 2024 16:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733849472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vMnB3kb2JtQyNov51Zx8i+pPJXdZR0HwIYulwGwDCA=;
	b=nh5qNTog2K/ZqHSmoq3vLssZql5NpKCAZUycCIHEMW6G6bRNnKWbcp/1GuK9kIZzKc6od5
	nXvvA2vYaPzFSwoU1Gk0mHvSigN3weiOwXc7ayfziTkn7XRo8UD3BfuShb4uzUbq/9JKe0
	qsx55b1reyRyIhnMOiYkJdcfqVsiL4IVbkC3SvmisspV6SIyf4KKyRiieTEdgvGPIxf7c+
	FIzrjf6z8RUuB8Lj0Q4+/EJI2P4nkXAmV+zVe8/hGjzswyX95M9//M0P21jWXP3mNvtFaR
	W+0N8b9Ol9m8a1vVIXzzwZpOryPvKbWoGC3yXyMdSmBAW2Qut2uSEBS6roc4SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733849472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vMnB3kb2JtQyNov51Zx8i+pPJXdZR0HwIYulwGwDCA=;
	b=cl8sSAvuTtfPJbw3uRXjPW+/s93PxS0z3ITi1wlZXKK5LSa2HgTjAs9z4ahTOstkdtXDMt
	kVahzW8T5rXnRlDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeature: Document cpu_feature_enabled() as the
 default to use
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local>
References: <20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173384947108.412.1870477767534160333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     4bf610499c429fa0bfb3fa94be450f01016224c5
Gitweb:        https://git.kernel.org/tip/4bf610499c429fa0bfb3fa94be450f01016224c5
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 31 Oct 2024 11:34:01 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Dec 2024 17:34:51 +01:00

x86/cpufeature: Document cpu_feature_enabled() as the default to use

cpu_feature_enabled() should be used in most cases when CPU feature
support needs to be tested in code. Document that.

Reported-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local
---
 arch/x86/include/asm/cpufeature.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 0b9611d..de1ad09 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -132,11 +132,12 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
 
 /*
- * This macro is for detection of features which need kernel
- * infrastructure to be used.  It may *not* directly test the CPU
- * itself.  Use the cpu_has() family if you want true runtime
- * testing of CPU features, like in hypervisor code where you are
- * supporting a possible guest feature where host support for it
+ * This is the default CPU features testing macro to use in code.
+ *
+ * It is for detection of features which need kernel infrastructure to be
+ * used.  It may *not* directly test the CPU itself.  Use the cpu_has() family
+ * if you want true runtime testing of CPU features, like in hypervisor code
+ * where you are supporting a possible guest feature where host support for it
  * is not relevant.
  */
 #define cpu_feature_enabled(bit)	\
@@ -161,13 +162,6 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
 /*
- * Static testing of CPU features. Used the same as boot_cpu_has(). It
- * statically patches the target code for additional performance. Use
- * static_cpu_has() only in fast paths, where every cycle counts. Which
- * means that the boot_cpu_has() variant is already fast enough for the
- * majority of cases and you should stick to using it as it is generally
- * only two instructions: a RIP-relative MOV and a TEST.
- *
  * Do not use an "m" constraint for [cap_byte] here: gcc doesn't know
  * that this is only used on a fallback path and will sometimes cause
  * it to manifest the address of boot_cpu_data in a register, fouling

