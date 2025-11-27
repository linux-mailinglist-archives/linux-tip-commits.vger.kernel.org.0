Return-Path: <linux-tip-commits+bounces-7553-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD8C8E81B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 14:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83EAD4E0206
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9412750ED;
	Thu, 27 Nov 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RhPM6cpm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QCHmxZS0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798317A2E0;
	Thu, 27 Nov 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250761; cv=none; b=JoEnFiWSKDmLC0V321PMceHnp5Tslw4BgGF4b3OfyYG8NsFZ+U8f21wBPEGPrXhQvbMPruC2iX6uq9xOpcVODrEDg+jFTfQT55QX/HZ8+H6WROV7oMxe+rPbMeZSf+Zt2+Rku+t9R/CTMBIKKFSB/gMUjfeYrOrmj5/L6uYRqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250761; c=relaxed/simple;
	bh=BJWlzz/wqxrlkJ50Dk8nj4OFt2Od9tQtjwEMpkA/1nU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kw2SaK3v8z4yh4WxvkCG1ZivMpUpQCoCUG3CWFY3WgT/wcLTc3SjY/bH9fpX03r7v3k1T1qCJqj4oiZroyslcn2UQVx1ZX+iHQ8KIly2zjkTkacOXUwsLV+ewJF2PjeN+FGfMiVGpISLw8zmXk29V1li3rnhnnjMrjosVOa1w3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RhPM6cpm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QCHmxZS0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Nov 2025 13:39:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764250757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCW6j1nG8z+Y/fXU+nQfbpyWZZfUZhmX6mrayIZIk54=;
	b=RhPM6cpmuHxZwuXrI6hEtxq+qBY1EJKSLdY7R6mddcRM3Y61RLKsBiXXKsNUXUp5Zqvgd8
	eChN3Iq1pN3gcm5bsFm/TIbX+bef1WFoXjpdHlFiKwGdplkiIKxTiUNmXicXfWr6gu7Tk0
	rzFUNYGVyA0kjIay2+LXqf/5MFRiG05lYYe/csY/jvCHBPMIthX0s5kMSqDNnIq8qyGj2M
	7PhflAqUx+QcQQdU/N0gk9X2y9rdBk77nDu3smrRL9EVoTHlTcVtHAZB6l2iiH5JlqDt0h
	vqlRvr1eTbgdCyZO/vLMHDftUYT/O+zcuwuiqg5Kiywm4K36Xshhfh8SKOYm7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764250757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCW6j1nG8z+Y/fXU+nQfbpyWZZfUZhmX6mrayIZIk54=;
	b=QCHmxZS0B3NID5q4KIoOKDcqfYwo5nWJ45a3WcsoMe0P1agFAAYxImZevqAV3nJIiiwlbp
	91NmX+EYOp8FbrAQ==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Delete disabled debug code
Cc: Brendan Jackman <jackmanb@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251003-x86-init-cleanup-v1-1-f2b7994c2ad6@google.com>
References: <20251003-x86-init-cleanup-v1-1-f2b7994c2ad6@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176425075553.498.11965992722021819677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3d1f1088455d9a9bce51f0c1e6a81f518a5cb468
Gitweb:        https://git.kernel.org/tip/3d1f1088455d9a9bce51f0c1e6a81f518a5=
cb468
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Fri, 03 Oct 2025 16:56:41=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 27 Nov 2025 14:32:16 +01:00

x86/mm: Delete disabled debug code

This code doesn't run. Since 2008:

  4f9c11dd49fb ("x86, 64-bit: adjust mapping of physical pagetables to work w=
ith Xen")

the kernel has gained more flexible logging and tracing capabilities;
presumably if anyone wanted to take advantage of this log message they would
have got rid of the "if (0)" so they could use these capabilities.

Since they haven't, just delete it.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251003-x86-init-cleanup-v1-1-f2b7994c2ad6@go=
ogle.com
---
 arch/x86/mm/init_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0e4270e..1044aaf 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -504,9 +504,6 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsig=
ned long paddr_end,
 			continue;
 		}
=20
-		if (0)
-			pr_info("   pte=3D%p addr=3D%lx pte=3D%016lx\n", pte, paddr,
-				pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL).pte);
 		pages++;
 		set_pte_init(pte, pfn_pte(paddr >> PAGE_SHIFT, prot), init);
 		paddr_last =3D (paddr & PAGE_MASK) + PAGE_SIZE;

