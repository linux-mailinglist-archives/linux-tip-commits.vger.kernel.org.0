Return-Path: <linux-tip-commits+bounces-2728-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C23FF9B9F99
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D153B20C93
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4CE18B468;
	Sat,  2 Nov 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W503chys";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IVEq+tBN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC84189B8F;
	Sat,  2 Nov 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548219; cv=none; b=NrsmDOnRjexRbkG8edMnUSbN5bH/ixN0CLAwH4mpyOcIk4PYQpaqBTHwRvmbQQhPjkrjxv+wHKgdAddyfM5w9Wsmvy/hnpGUFY7GoxJWgXeYJ9Fz979OK5O7kNsL7giLPWgDT8fs2HmrBxdExP87TdnrWWW0Ru2bYSKPYd/F/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548219; c=relaxed/simple;
	bh=X02SHzf8H8Vyj/JHNz9/LxvB0wQOR+MoMIPvbxdTnsE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WqLNhHuIcrcfadtOtK0XcgyG0COaj6T88XYwRdVzlkP5QJTUk5HblVhPk04QjIRClqs9vyHbqxJ5c78VaVoP98c7M7lHL1qPlhhq8wNSrTD89fX/uNPFpGnBWnvzrK5Lpwvq0VRjRxbpDm5Lde8uLCCN3q90OIYB4UFWdf2S/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W503chys; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IVEq+tBN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9QSegqVbwdQP4FMRJ3M9zWkv47aaN/o8jE4wbvA6C4=;
	b=W503chysY5aBFZOcbtombQMNmWNpXiXAxe7AUtYflLmBpICwtKXXRNafN2BdYTLwJkflyG
	YHHGhae/iQ/0T7zqRenq91BqBjl5bz/2r6X8RgYHbN9jPE83CZdAFDnhAvfbPZiDgdSJ1F
	6DQBjaaNpw9k5pB1jZF14rUyGJJmEwFoUOB6yQZtq8x8+WN28Z/mOHJSXeB/R8LL8UfDo1
	3238k6MgjTVO6zDFqal49CbRRTaC+Da0mCWLsWdiJZKtgRKmog7qtxcrBi+8HgQBUsE4cq
	ODIROFlb8pZh8Vn9LUkGjMZYbtYEiDvUkpz/Rc8rYwAX4v4XXIdlD7FXAHH74g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9QSegqVbwdQP4FMRJ3M9zWkv47aaN/o8jE4wbvA6C4=;
	b=IVEq+tBN1NVCnAQiTCQUBO5kDjJC5zzsOxUCZcH4E1b6nsXNeXkqgqkAGJfdRxRKmmcqjN
	zUSO2KwkietW0zDA==
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
Message-ID: <173054821528.3137.17045473266195256592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     d4526a2d2d01e4dcb09c5535d3d4bb6ca763efeb
Gitweb:        https://git.kernel.org/tip/d4526a2d2d01e4dcb09c5535d3d4bb6ca76=
3efeb
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:35 +01:00

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

