Return-Path: <linux-tip-commits+bounces-4230-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F1BA63522
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CC17A596F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B753C1A0BCA;
	Sun, 16 Mar 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZ6kdRMB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lnXXBAPo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9F10F2;
	Sun, 16 Mar 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122902; cv=none; b=j6fl94h8Cp7liKA6vDUDPqvn5f2BLNZyciRws01EjJGt8pkWkE1Wf7xL6U0HIHT6VLIrVbGPhPyZJKM5H0j9tP/ZSdOny/djg/r4rTGizLjAMCc6oiJpbzDGLujfdXwDESiCbi5LGHUfQ35fDFLbsJQERovyTfF5qEbiIRePDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122902; c=relaxed/simple;
	bh=kGukX02//m2XNgtylBTQDYGAxHM/n3AQZZFhjIQ4W4o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RkRy0Z9pf4sQyMtTnJR5xIHOnp0suS+GywiQmzxyYaAMUgEeNXWMp6uFzxeevD+0QQWWx3VrP4hcKQdf06XIdfiNRXGaVQTnZHuFEVzYKa3Lo+Rkcgc519l246vgr5GqAA9nnUhEBNJKIAd8R+gsofDOmO0EVMIFIjZUS8gLT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZ6kdRMB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lnXXBAPo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 16 Mar 2025 11:01:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742122898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygwwbycyvOHIZAggJKqAJMubjGfnOvB2VRD+aEf4jao=;
	b=GZ6kdRMBALA0e1/3JcXccwrhBM4pv6cE18mxtG6KRN7FUNFLHyEJEadaFMnUn4rkdcduKF
	vfBQvYnLkjdj4eeEsP2O6ViQfjXzFef/R4tXMRtaAzKzyGBP58qkmcrG1YZWYrKZSYSS2p
	5AQLBIT5esf+fUWMIG/H/sI/P+gdvQim1jOiJuvuI/gnCV9WmuvEpiQV6YwciC4lEhqgqr
	pfELe3KClwS+5X2sF7lEf043lSJ9HGViyghz2Y7MyWq0qWWsjupWakkdP4os0SzI/OQjc+
	HIOpb4QySoaZTFifh09SUhoMvdr7JgQuHq+w1ExYExu7T2O7bcyBjbWQnIW4Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742122898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygwwbycyvOHIZAggJKqAJMubjGfnOvB2VRD+aEf4jao=;
	b=lnXXBAPoJWY9i/j3dN5hPc8zQpgf8UmUxtIrX0QTkSbsePVNLvf24SgEsQoVYaUaKRN8kr
	mRtM74klKUoC2+Ag==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/syscall/32: Add comment to conditional
Cc: Sohil Mehta <sohil.mehta@intel.com>, Brian Gerst <brgerst@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314151220.862768-8-brgerst@gmail.com>
References: <20250314151220.862768-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174212289213.14745.11904990695632151378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fe35c87ad8e7795e1ab020ce2023e952806353d0
Gitweb:        https://git.kernel.org/tip/fe35c87ad8e7795e1ab020ce2023e952806353d0
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:20 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 16 Mar 2025 11:49:42 +01:00

x86/syscall/32: Add comment to conditional

Add a CONFIG_X86_FRED comment, since this conditional is nested.

Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250314151220.862768-8-brgerst@gmail.com
---
 arch/x86/entry/syscall_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 993d725..2b15ea1 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -238,7 +238,8 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
-#endif
+#endif /* CONFIG_X86_FRED */
+
 #else /* CONFIG_IA32_EMULATION */
 
 /* Handles int $0x80 on a 32bit kernel */

