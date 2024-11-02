Return-Path: <linux-tip-commits+bounces-2699-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123519B9E94
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57882821CC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF9174EFC;
	Sat,  2 Nov 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSyH5qj3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4e5+gL9F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8FC170A3A;
	Sat,  2 Nov 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542215; cv=none; b=XCBAZ6i2BnpSCQW3Uuq2cJYg4YVh0wePc7gunzJ9Ap4Pjta6YG6BFt+hHvVLPZV6RbsyDm7PktanBlc8zyxLM6BVaHAOp9ZWRAHmXMoxfs6oUf65RhRPKUw2Iq/okI1EpG/LIRSAAA7W/BylDdIY4vcR3z4d24DCwP9zuqYrppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542215; c=relaxed/simple;
	bh=S07/38PyqrRDkDIGRMtdvYq2dOOLKw3sryJH3cpNs/0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U0evllTSzjtZjuUXmYM79oVBQzUYiYw7sCFXVBN/LEMBsefg2agvnJWHam2lbeS628HOLgKoyabYl5n1pjxJKFVTO/WBGCAb6zvoFnxUmv5lsAlNerQ9Dy5qfJZp610ekfq7p2sJAzKUoLCTkHVdN6B7q9bxmNlFpOmplyhlfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSyH5qj3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4e5+gL9F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vikD68bACCIMQ5f9qeKUTg+RQoT5MeLk4UxwYj6KoM=;
	b=HSyH5qj3c4jRUoGHaApZ7zn4qnhsRFDf/OBohZzldPsEBVE6fMwjq6mAtx/JqNH30il7W/
	ylLMg3IvJHmuPmoNGVlF8S5cOxcMLDxD8HE4NNOkx2fQbmrsvCnpGAdLVnO4q0prliukiR
	CML+Debivyf31/WbfLb73wuuBXNEkE/9q0NClzIw76NVmDOvXjivPnf+I7DKfp6vV+MITG
	Dv3uXjrYwxQS0T0/c4J9lNAUCn+OThe/apcAWciaL9SDPkA3puDgyhfqMWAkcdsuuD03JC
	1GeXP6cXDwOxxs5Ul2hDX7CaImWVrcNwECmdxfwFMjGfvP1K5Yh13Gt2uSzSPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vikD68bACCIMQ5f9qeKUTg+RQoT5MeLk4UxwYj6KoM=;
	b=4e5+gL9Fuy/T+dQMEZVnGt+3h4CHC1XnwYkpYV7OdfehxP9aULz3A4bZIk2sm4sy5e4h3x
	yfnIcQXWOaXY2ZBQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] powerpc/procfs: Propagate error of remap_pfn_range()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-22-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-22-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220628.3137.3964639418525957437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     17c84d6b817a37030a815006d30b66d14e260674
Gitweb:        https://git.kernel.org/tip/17c84d6b817a37030a815006d30b66d14e2=
60674
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:15 +01:00

powerpc/procfs: Propagate error of remap_pfn_range()

If the operation fails and userspace is unaware it will access unmapped
memory, crashing the process.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-22-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/kernel/proc_powerpc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_po=
werpc.c
index b109cd7..910d208 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -33,10 +33,9 @@ static int page_map_mmap( struct file *file, struct vm_are=
a_struct *vma )
 	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE)
 		return -EINVAL;
=20
-	remap_pfn_range(vma, vma->vm_start,
-			__pa(pde_data(file_inode(file))) >> PAGE_SHIFT,
-			PAGE_SIZE, vma->vm_page_prot);
-	return 0;
+	return remap_pfn_range(vma, vma->vm_start,
+			       __pa(pde_data(file_inode(file))) >> PAGE_SHIFT,
+			       PAGE_SIZE, vma->vm_page_prot);
 }
=20
 static const struct proc_ops page_map_proc_ops =3D {

