Return-Path: <linux-tip-commits+bounces-5166-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C03AA6D95
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D93F4C109C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD8235371;
	Fri,  2 May 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UHK8VVz8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhJFPhl1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC222D4FF;
	Fri,  2 May 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176667; cv=none; b=lpAETLnpVGs4pDkAInGa5TmyWkbHf44n+q5soXazxwV1zYoEFYfgGmy+R4aowOdoF9Jjm+dWNypeSjbAJl53n+BVjPE6nfEG4IsCwubU/4WiMAveKDkf2lPPX4DO9uvjyMqNzRVMvObqPwVgdA0nK/kNUEmXCb4PJ33hIyO9Aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176667; c=relaxed/simple;
	bh=ejtM6b7NahzlScbZ3g8VvRC6Zpmx9U+f7SaZhWMWvT0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=km0Pe1P15GT4+W96jZXQ4+YYfDLcGL9Z9euaAeDXaQsqOxge57hS6hw2cne3y1dpM3N7V17sD6hp3KcYaZa0nJjNcS0GA8ODGo9feq6OZomYAGnPYXEFz+38Xv0//dDRSSQ68KgxdjDV/Pifo3Fzw7Ofykn7BRynfNviUzAsGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UHK8VVz8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhJFPhl1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SReWcY/7sE/4hI1pEr6al/1umfK2uLW2nLw9lQWEpGo=;
	b=UHK8VVz8RzCATlCHJmYh/OAUbljq5h5hXiKecWk/igJdS0G1T25YvXNoLWm3rbuYF1MBrS
	obaxbyQUBkWLUfkax6r4q4F/UL/WFlh2CJdoBQm84TVHoK6VDBv8L3mEiDaU7urQ8B80sp
	JcebfjQiYV9eqcuqbcKIqcAxJlzEs6xQk8KqkjXWpPoWJHA9FE4ZsuA49aaDVM/CEAvVXN
	qlwBa41Yds5I3Y7V6MrIvLR6OOq6IAtDh9/T1WC63UMR8304aqP7IcBU07XAvFCc1InoT1
	d2grmn1WOWGuflAZOqskazGpt5FkOB27MZVWIVWLZP5JlWwuqp1j8sZTK/N5wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SReWcY/7sE/4hI1pEr6al/1umfK2uLW2nLw9lQWEpGo=;
	b=VhJFPhl1Pw2wpqBhvGAKDknrhn5oxmNpE2kUEB2N+tyV09kTaTNV8uMbU9weDKE/8lj33Q
	w1kPDin8JReOX8Dg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/msr: Add the native_rdmsrq() helper
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-9-xin@zytor.com>
References: <20250427092027.1598740-9-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666234.22196.7302164933927481240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     ed56a309f7e1b05c15702ea1275172d507a606f4
Gitweb:        https://git.kernel.org/tip/ed56a309f7e1b05c15702ea1275172d507a606f4
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:20 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:36:35 +02:00

x86/msr: Add the native_rdmsrq() helper

__rdmsr() is the lowest-level primitive MSR read API, implemented in
assembly code and returning an MSR value in a u64 integer, on top of
which a convenience wrapper native_rdmsr() is defined to return an MSR
value in two u32 integers.  For some reason, native_rdmsrq() is not
defined and __rdmsr() is directly used when it needs to return an MSR
value in a u64 integer.

Add the native_rdmsrq() helper, which is simply an alias of __rdmsr(),
to make native_rdmsr() and native_rdmsrq() a pair of MSR read APIs.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-9-xin@zytor.com
---
 arch/x86/include/asm/msr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index e5f95a1..adef3ae 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -90,6 +90,11 @@ do {							\
 	(void)((val2) = (u32)(__val >> 32));		\
 } while (0)
 
+static __always_inline u64 native_rdmsrq(u32 msr)
+{
+	return __rdmsr(msr);
+}
+
 #define native_wrmsr(msr, low, high)			\
 	__wrmsr(msr, low, high)
 

