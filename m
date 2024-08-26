Return-Path: <linux-tip-commits+bounces-2124-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C479395FA37
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2024 21:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9D41F22AD9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2024 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE419939E;
	Mon, 26 Aug 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osEZQ6Dx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5z9EY5he"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559311991B8;
	Mon, 26 Aug 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702314; cv=none; b=Q49zbjDczEDkIIUqMqH1LtsYETNdb5fIgnPgs565ItiPUYOOjdz+gYBdftL/QOg9foxxPbnvG9+zS2SzxVDVVZRJlSaah7YSuVPUmUzxuP91a/RLSyiMkDiKER36HW3blpzfUhq9Weio0xLiKGorlq7QhQ5ASkcRy4p3YbALwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702314; c=relaxed/simple;
	bh=BmuMNqwzgvM7DKlY+zSNGaTo20tKq6d6hmRvkEARdVs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BsdHiy7TVDFyhKQ2ltC+rKTXTQwG68Zky/e+rCtNR8xOXIwXfH2rMUnKObua2pY2XWHu7QXHBG77NVcwEm3Tt15N86xS0eZo7Eos5MaqaPou3vgOmxX//NI0THiaxJOWZW1Gk/mfS5cJdHfgccBOfDH5uQx68mGjTyLGuZq0Xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osEZQ6Dx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5z9EY5he; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Aug 2024 19:58:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724702310;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DhhgRwj2YRc5cVJ8j9t533aTKEzCg9IQSYgbyaJf6XA=;
	b=osEZQ6DxudUJi1NJke3YB4t3s9rNktg1Qqs3ZG6jWTqTXRlqpscVBNgo6uONIlmHOUkpw9
	IJTexCoVa7gnbBwy3DMvwO31UNsMUmL+yM+hhK+UFxrRTb4rJmaKpbc8s/1nqOaqwgmiQ0
	pUa5CmYuCx1yZPW8Dcq3ivpu7aOb7ixOL9qh+BLLUGojIkNk/IxsNgKbHkIacwb+JpZKS+
	LfwhiPeFa8stzrW/GV/zmObR9U/skTtqX0PT18FAo/bqJcTHYyBjW4TjYJgCxNmlr4ZqtM
	9eKaVQHQPyw4s9EqveR8t0yeQ95Msnpls6FseSBtLYqcipNVv3Hgo6Pm/+tHsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724702310;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DhhgRwj2YRc5cVJ8j9t533aTKEzCg9IQSYgbyaJf6XA=;
	b=5z9EY5heL9eC2JskpQRc6YuWRg04g1lynqGoDAqf7Eqm6tSNMZpiNmq6NRreN4deGlYswP
	1BNhux1R8nLL9gAA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tdx: Fix data leak in mmio_read()
Cc: Sean Christopherson <seanjc@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172470230968.2215.7634345902680513698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b6fb565a2d15277896583d471b21bc14a0c99661
Gitweb:        https://git.kernel.org/tip/b6fb565a2d15277896583d471b21bc14a0c99661
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 26 Aug 2024 15:53:04 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 26 Aug 2024 12:45:19 -07:00

x86/tdx: Fix data leak in mmio_read()

The mmio_read() function makes a TDVMCALL to retrieve MMIO data for an
address from the VMM.

Sean noticed that mmio_read() unintentionally exposes the value of an
initialized variable (val) on the stack to the VMM.

This variable is only needed as an output value. It did not need to be
passed to the VMM in the first place.

Do not send the original value of *val to the VMM.

[ dhansen: clarify what 'val' is used for. ]

Fixes: 31d58c4e557d ("x86/tdx: Handle in-kernel MMIO")
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240826125304.1566719-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2ba..da8b66d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -389,7 +389,6 @@ static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 		.r12 = size,
 		.r13 = EPT_READ,
 		.r14 = addr,
-		.r15 = *val,
 	};
 
 	if (__tdx_hypercall(&args))

