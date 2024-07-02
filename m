Return-Path: <linux-tip-commits+bounces-1583-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4C924A02
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 23:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649CD1F215AD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2D201265;
	Tue,  2 Jul 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FvZAR+J1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UED8poPi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718620125A;
	Tue,  2 Jul 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956395; cv=none; b=TVt6sp8boKRjIoKJaA6R8+yZIE8Lj9HrjiY0uV5Mcz27T4i7w0J4M6bKf7Sc8pmdBXWgrf/4fmMEljB89ndKVQrfJ7TOQOA1sDUOHh0nMFwoiQ/rAJ4v7vpuYViDY5h0zjpOG28e+R0etXGBC10J+xERKa+8F2PhSgQApO7pSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956395; c=relaxed/simple;
	bh=boNYnQaxAbncbVDKC6riwSLR2cfzkMgrICaD3z4Xm7U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oFsGWu5x6F8j5BVeQdgNfeLqV/e/x4GHGeMRJMIBuMr9fUsA1ae9cjkSlJ6AvBjV539sN03DBYm00RESCV5dhjPaYFYVwLwStBEgfErooTZbRT6Nlvt1ZHwHdQeDUoNXBZwzBb/osntp9vvCT1Vo55z+UdKY0vAVaAzz9lEePe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FvZAR+J1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UED8poPi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 21:39:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719956391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HhKvrwzqCmcb83qItVGlKVvu9jHjlPt6Zbqq+IyY0zc=;
	b=FvZAR+J1HbZnYQ9Io2UM1L+olVq6ltvbwerbfsoaUI/fAkJ9U7hzNmGvYfdYCgJCsG3vau
	lvCZsva8CI5zA/e+UWqiu1Ga5puHxO17KUYxItvsel/oiK8SMr+AIpej5cfoC8szM7Sq5g
	btTZCiAuWslqpvlKT/M08Oq7xDBtm0nIBTRlLlwaPNKOpVeH3OYzolStWtW2FKPkZbOctl
	bYOxZjKAt/yItZ3/v9Eru2WEJ9EF6o3wHPFEYvq27IujYFS1iGsXs05q2BgjtNZES0ZjTF
	0FO1lCGQ8VsdfyovkreWgTILbfdTCh/RrHaFV2cLltFYHG6xoL+8KTJj7xl7SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719956391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HhKvrwzqCmcb83qItVGlKVvu9jHjlPt6Zbqq+IyY0zc=;
	b=UED8poPi037o9cTN/3lzDhxP/4fHMvH+LdMpszFoPwYqYx435kEPDghDvvZwu8hEE2bBRa
	hG51zH257m53cfCw==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Cleanup prctl_enable_tagged_addr() nr_bits
 error checking
Cc: Yosry Ahmed <yosryahmed@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171995639138.2215.10418408006509074215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b7c35279e0da414e7d90eba76f58a16223a734cb
Gitweb:        https://git.kernel.org/tip/b7c35279e0da414e7d90eba76f58a16223a734cb
Author:        Yosry Ahmed <yosryahmed@google.com>
AuthorDate:    Tue, 02 Jul 2024 13:21:39 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 02 Jul 2024 11:33:44 -07:00

x86/mm: Cleanup prctl_enable_tagged_addr() nr_bits error checking

There are two separate checks in prctl_enable_tagged_addr() that nr_bits
is in the correct range. The checks are arranged such the correct case
is sandwiched between both error cases, which do exactly the same thing.

Simplify the if condition and pull the correct case outside with the
rest of the success code path.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20240702132139.3332013-4-yosryahmed%40google.com
---
 arch/x86/kernel/process_64.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e9f7cfd..2264723 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -812,6 +812,9 @@ static void enable_lam_func(void *__mm)
 
 static void mm_enable_lam(struct mm_struct *mm)
 {
+	mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
+	mm->context.untag_mask =  ~GENMASK(62, 57);
+
 	/*
 	 * Even though the process must still be single-threaded at this
 	 * point, kernel threads may be using the mm.  IPI those kernel
@@ -846,13 +849,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EBUSY;
 	}
 
-	if (!nr_bits) {
-		mmap_write_unlock(mm);
-		return -EINVAL;
-	} else if (nr_bits <= LAM_U57_BITS) {
-		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
-		mm->context.untag_mask =  ~GENMASK(62, 57);
-	} else {
+	if (!nr_bits || nr_bits > LAM_U57_BITS) {
 		mmap_write_unlock(mm);
 		return -EINVAL;
 	}

