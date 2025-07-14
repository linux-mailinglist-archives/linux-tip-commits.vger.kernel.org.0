Return-Path: <linux-tip-commits+bounces-6118-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616BB0482B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 21:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F57165CB8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768EB2459D2;
	Mon, 14 Jul 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qt1RL4as";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06/no/YE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7A14658D;
	Mon, 14 Jul 2025 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523144; cv=none; b=qc13MTfR40Ywmbl+8ws3uzVBeZfdpq/Ey83Da4avE8c5lWLYNyrx2jaHqSC0YVTr0Grnp6LCnOk6zpRSR2J3NKGVoh1ed6oYfHG/zxd963kUrQVD2jUBIkGtDC9Dt2B9Ei4ZfzAyZKIYq9MkbWRpV7VXeUgQk01DrDYlsFPlsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523144; c=relaxed/simple;
	bh=Azv3k/ThZYtlW5nK20idCtvn2Ft28hURrtlSFEYJfLs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oH/AxllhTkFm80uTf82SAdylEF503GmLmUw4VA16GfViBSakHFAl3HnKSMtoLhFQAU2OGOb9pmSnsUuIxseRgUqKYCtVkWtjvg1/87GlMq8pFb9cFrBgMjQcIdEzBkFu7bn3ferktTnionFTXfXb4OGcnzrATNCDwW67Vid38yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qt1RL4as; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06/no/YE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 19:58:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752523140;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GWO4GMPYLOEQtgkv2KC1PnbFMJ6jGyBFoUsYnA/0WM=;
	b=Qt1RL4asUmo5tvApMQJGrSNjuSviSjWIHMvz/u+Zn55UXYMh1wdIz0VKu3Q+tyK9u3bRFg
	fc4mq+gE8KHSFbj8CZgR4zMY7Z+ejGkWp31kmabDlWjQxybCew8bbD+PeC1Gz5TxmOWfli
	/ALQhUex8hce5vd20MYSldNjUm90c0+mqMx9hjw6GEuEXfeguPs4m0evRT6GidH48nJtqI
	MXp4heMEseTunoLZlT4x8VkPXHMIt1MYEP7xlk0/GhQ3wvDYqGgQ1crr5Fkz8p2KToHMQ1
	Bvw20ybSO5alemW2AjZUYM76YK5HML1iWQwb1i2pycMA1Lq4o/YZGFPQPRxgVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752523140;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GWO4GMPYLOEQtgkv2KC1PnbFMJ6jGyBFoUsYnA/0WM=;
	b=06/no/YEiYqCWmXDwIzUmmf6iD8nrRQ+jrHd3IdqvLdRyc+r2/rIwhNp5wGF52//jLho2Z
	6Z3JlWksU0AbPpDw==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Remove duplicated __PAGE_KERNEL(_EXEC)
 definitions
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714170258.390175-1-nik.borisov@suse.com>
References: <20250714170258.390175-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175252313924.406.11128056670090257358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0877ad1c4e7ab0b873c3a63c157ed2ae34eab77b
Gitweb:        https://git.kernel.org/tip/0877ad1c4e7ab0b873c3a63c157ed2ae34eab77b
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Mon, 14 Jul 2025 20:02:58 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Jul 2025 21:34:42 +02:00

x86/mm: Remove duplicated __PAGE_KERNEL(_EXEC) definitions

__PAGE_KERNEL(_EXEC) is defined twice, just remove the superfluous set.

No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250714170258.390175-1-nik.borisov@suse.com
---
 arch/x86/include/asm/pgtable_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b74ec5c..a5731fb 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -214,9 +214,6 @@ enum page_cache_mode {
 #define PAGE_READONLY	     __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_READONLY_EXEC   __pg(__PP|   0|_USR|___A|   0|   0|   0|   0)
 
-#define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
-#define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
-
 /*
  * Page tables needs to have Write=1 in order for any lower PTEs to be
  * writable. This includes shadow stack memory (Write=0, Dirty=1)

