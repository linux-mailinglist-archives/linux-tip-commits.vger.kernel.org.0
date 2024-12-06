Return-Path: <linux-tip-commits+bounces-3002-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03C69E6BD8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB8F16DAA6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB85201114;
	Fri,  6 Dec 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yP9YgFnu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5Wsn0nE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC01201006;
	Fri,  6 Dec 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480212; cv=none; b=euJBSi2lOJzbK0akLsOWHvMq2Ac5R3RWOVCoRhtkm6QdHm+V8U214sb1dhD7PrHfrX275Ugw32Bvgdtyfv7wRHLqaFkNwicYoxMx6CKvpeDSE6LL12Cappqgjo31XbtATWdxSV9LgBSBmW7K2EbzrCHoay92zJudICd+o5fTT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480212; c=relaxed/simple;
	bh=+srfOzshgbw1yr9xuuVmU8SA6jLJbsQ6wXHDz6As7pI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LACs68n09zblDmTQXZ0ADrGNSWR5ANYkjWHKFZdEBuMLqKzRTq8o8jOZg8aNqNUtvbja8UMul4fsxR4b9lpxSuO1meyXSNJ0kRsrUTaGW9AGWklljZYrHESVM23nuOf073Y1cFlpyODnAxp9kCEcEKGieR2GJBUcHob9n7MCpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yP9YgFnu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5Wsn0nE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJHQKXrrFHgEsQSN2SV0zVCibaUHNFfLhfrV5CSJp1E=;
	b=yP9YgFnuiwRdgiyCXdtiiF6yFK/da2cTbmXZJ24eKixc9Jg3/txvD3NGyS/DfdNyiAfAzM
	vk0UYeUNswFAF4FBVB9K5veHZUxpmqAOkW9E+Q9aQk8J4+rI1UfpMdf2K5RxVUhEGM7rkb
	vAAWoMCfGQahSMwjsZDu0xHotq9I35QOE/F6+4D7ZrusGmG4Swvs8ILigb9NM/6RTa4e5m
	nCATxCkYX6XHFjz7KrJlumL2PsHDVSKQCRUL/diCHkqoOS33mpW5SVhmsLjlUQDWRNL0ZJ
	B+H7x0dEgQiTt3xVUrXymgeFMnjhmMcydxwA/d9Rp0BTWYOVKNWTqgEuzAl1FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJHQKXrrFHgEsQSN2SV0zVCibaUHNFfLhfrV5CSJp1E=;
	b=J5Wsn0nEKbnN2C/ZvYN6rqz1VC+1fqv36kTpW6xWJfALG+CqL4dDJEQEzRDnZkHT3cTmsT
	UPTARPvVLjh+qsAg==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Copy control page into place in
 machine_kexec_prepare()
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-7-dwmw2@infradead.org>
References: <20241205153343.3275139-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348020817.412.3867427890031364695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     6a750b4c009936f352aaac0366f5f10fcf51e81b
Gitweb:        https://git.kernel.org/tip/6a750b4c009936f352aaac0366f5f10fcf51e81b
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:12 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:41:59 +01:00

x86/kexec: Copy control page into place in machine_kexec_prepare()

There's no need for this to wait until the actual machine_kexec() invocation;
future changes will need to make the control page read-only and executable,
so all writes should be completed before machine_kexec_prepare() returns.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205153343.3275139-7-dwmw2@infradead.org
---
 arch/x86/kernel/machine_kexec_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 7223c38..3a4cbac 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -301,17 +301,16 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long control_page;
+	void *control_page = page_address(image->control_code_page);
 	int result;
 
-	/* Calculate the offsets */
-	control_page = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-
 	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, control_page);
+	result = init_pgtable(image, __pa(control_page));
 	if (result)
 		return result;
 
+	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+
 	return 0;
 }
 
@@ -363,7 +362,6 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page);
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;

