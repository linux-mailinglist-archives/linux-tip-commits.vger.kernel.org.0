Return-Path: <linux-tip-commits+bounces-3716-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFA5A48808
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 19:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC518188A0D6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E481D935C;
	Thu, 27 Feb 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NjL86kdc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlM8hHPb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037D270023;
	Thu, 27 Feb 2025 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681887; cv=none; b=tO/zUWwkq+dRGcl8dBS6wXLY2LcAQoq5gVJj+3trMisOMer/KcpkMNrVDhDItH9ZnuPaDKnEHlPRRyaRrt9FI/hNmG9+tWpjik1PcdlIXQ5LTvhS8amQEvmv6293xIBbmDH/hAObiUlFSum0bSVtY/YOZU8pQWVixY+XuN8UAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681887; c=relaxed/simple;
	bh=dLc0fGYaI5kGCv2cRo0WyDWfAi9MumfRwn5a+QUiwLQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RnklgD6Bc4+IPyOsbJ/6eQ1iF48JbZq6BFuzrkGs5eIkAhsYestRHQYxXFym308Y9OPVq7WPzmWGB70Lr8ikR8htpRPQ3XI7wPqUOj1HEtCjjW4cfypREL6GLlEpgvNEXLY+yPoJPYMP1kF8FQzFlVTonsaY3Y+Ql/RARywj3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NjL86kdc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlM8hHPb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 18:44:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740681883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNZXkZ1cqd9GQL9UKi7a7g1q9+uZyTmumFskni4YGMA=;
	b=NjL86kdcbsGziL4L4aOImC7u6YRxeafrvaTnsNhMD0o0kUfY6HP+i/Z1a39mkYPso9INir
	9OPlNUQi7iBWkCUnomPseOfCQ1MBJ0DqRSeahFf0po0D89ohLxG7sosx6Mj8b5TxFhSgJE
	4kabRQ9pJ/seg+lxPz2et4/shKZ4wgI6JEQ23PKqA/Qo0bhAsAcaLbTNJTR0GTCrMOdN/N
	izBnAV7ZcoryOA0LUJuDBnuaY5aUlK6nOj68XyNjFqBEv7/todv1vNzuCpSHaIbgtHLor5
	8LQ9tzCUfXP4p8VRVmaWLUsQ8KphBxbRxLWGLLhDA2Ee25jG3RfstSGIsTI7BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740681883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNZXkZ1cqd9GQL9UKi7a7g1q9+uZyTmumFskni4YGMA=;
	b=KlM8hHPb517TdbBed2U1jmuu1lb6bHJsg90U6mNtqOmd2deP5tAmYOGSjdoP7KCPAKI9Hq
	z6/P5yrc9O/9P7AA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Disable named address spaces for
 UBSAN_BOOL with KASAN for GCC < 14.2
Cc: Matt Fleming <matt@readmodwrite.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250227140715.2276353-1-ubizjak@gmail.com>
References: <20250227140715.2276353-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174068187985.10177.15777454090979970918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     b6762467a09ba8838c499e4f36561e82fc608ed1
Gitweb:        https://git.kernel.org/tip/b6762467a09ba8838c499e4f36561e82fc608ed1
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 27 Feb 2025 15:06:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 19:24:48 +01:00

x86/percpu: Disable named address spaces for UBSAN_BOOL with KASAN for GCC < 14.2

GCC < 14.2 does not correctly propagate address space qualifiers
with -fsanitize=bool,enum. Together with address sanitizer then
causes that load to be sanitized.

Disable named address spaces for GCC < 14.2 when both, UBSAN_BOOL
and KASAN are enabled.

Reported-by: Matt Fleming <matt@readmodwrite.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250227140715.2276353-1-ubizjak@gmail.com
Closes: https://lore.kernel.org/lkml/20241213190119.3449103-1-matt@readmodwrite.com/
---
 arch/x86/Kconfig | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6595b35..867ec8a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2441,18 +2441,20 @@ config CC_HAS_NAMED_AS
 	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
 	depends on CC_IS_GCC
 
+#
+# -fsanitize=kernel-address (KASAN) and -fsanitize=thread (KCSAN)
+# are incompatible with named address spaces with GCC < 13.3
+# (see GCC PR sanitizer/111736 and also PR sanitizer/115172).
+#
+
 config CC_HAS_NAMED_AS_FIXED_SANITIZERS
-	def_bool CC_IS_GCC && GCC_VERSION >= 130300
+	def_bool y
+	depends on !(KASAN || KCSAN) || GCC_VERSION >= 130300
+	depends on !(UBSAN_BOOL && KASAN) || GCC_VERSION >= 140200
 
 config USE_X86_SEG_SUPPORT
-	def_bool y
-	depends on CC_HAS_NAMED_AS
-	#
-	# -fsanitize=kernel-address (KASAN) and -fsanitize=thread
-	# (KCSAN) are incompatible with named address spaces with
-	# GCC < 13.3 - see GCC PR sanitizer/111736.
-	#
-	depends on !(KASAN || KCSAN) || CC_HAS_NAMED_AS_FIXED_SANITIZERS
+	def_bool CC_HAS_NAMED_AS
+	depends on CC_HAS_NAMED_AS_FIXED_SANITIZERS
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)

