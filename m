Return-Path: <linux-tip-commits+bounces-4614-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85471A783A2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 22:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A92164671
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB2211713;
	Tue,  1 Apr 2025 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XD1CSDWq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UvH4XVFG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D3209F31;
	Tue,  1 Apr 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540806; cv=none; b=mqne8A5NOcGD0vHum4Ea+1Vmvmpcx0ZqLLZ/LBJ1vVF/JH0oDJQpBb9RCS5W9GkH/wC1xfBZlUCMTRJIJ8XOtBlrsZfQ0gTPhyjp5AVYuZYKR/qdyPJfhrQPeBPJYUpFroCakKlDG1b+hW+0f6xOcYWv+5VHRgFSXl3zRgoCpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540806; c=relaxed/simple;
	bh=jfPjGswlnkT38TujtD9AgNI6MdV9pFOfSTOePzsoXJA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UVCtki2Yzng1lx+UMLTOMjPTew9UsRTjEjCqO9xgMLuvWnMl+sR6dxolZ+pn7O9jM1bXn77dC+mc34IJLReHG1VH/wcMyyQR8fkbezQCSWXBpp/1Qz66BWL/iYA+OSgYjZUSDd+RVHgQbwrJZAhxPZAV2GEpSln3bAhK15DIk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XD1CSDWq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UvH4XVFG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 20:53:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743540803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FT2yOZMRQrT1aFCtj2pvEHYcFdddZ3PtsFP5hw2+3c0=;
	b=XD1CSDWqojTrdcP5Nn7ameBrNxJeEhuh5S+Xg0dq22O9TcFcTMgJBSoT8ZE53BmMtyfsEM
	a49tSpib/J9shXzOtpzNYC4oaSiYzqRqTQbd0D45KGFjRfzwCnfDHfIEPBzMxJECqe378W
	jVJqNGEq0487CZ/IBBTfdHWbDvwQtRzpgd2u/1U6f/CFxNEevatW31lqwAnB4+kAsW+k5u
	KIagdq+PFLi9o9tKnKgXBACa25YydwkDLnp2sBB67nIaoy81dPK1QPep99f9cKrKPtrhu4
	/YBjHd20no3Jazcii+dfrkyezgn5z6irGOjrwiQoD8E6WIkOAzANCBdlaTKqeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743540803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FT2yOZMRQrT1aFCtj2pvEHYcFdddZ3PtsFP5hw2+3c0=;
	b=UvH4XVFGaFBKBpED1r1mmv4dztKpJ6P3IZTsaX6uWm8AXUx0dtRPkBTlvLdt9anNjo2KTs
	ZAGQQ/pGeb5YAfAw==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm: Simplify the pgd_leaf() and p4d_leaf() checks a bit
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250331081327.256412-6-bhe@redhat.com>
References: <20250331081327.256412-6-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174354080253.14745.18272106825366513557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     4a490be3cb59c71dc84a363a251d466e2886ecd2
Gitweb:        https://git.kernel.org/tip/4a490be3cb59c71dc84a363a251d466e2886ecd2
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Mon, 31 Mar 2025 16:13:25 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:47:02 +02:00

x86/mm: Simplify the pgd_leaf() and p4d_leaf() checks a bit

The functions return bool, simplify the checks.

[ mingo: Split off from two other patches. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250331081327.256412-6-bhe@redhat.com
---
 arch/x86/mm/pti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5f0d579..1902998 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -185,7 +185,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
 
 		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
 	}
-	BUILD_BUG_ON(pgd_leaf(*pgd) != 0);
+	BUILD_BUG_ON(pgd_leaf(*pgd));
 
 	return p4d_offset(pgd, address);
 }
@@ -206,7 +206,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 	if (!p4d)
 		return NULL;
 
-	BUILD_BUG_ON(p4d_leaf(*p4d) != 0);
+	BUILD_BUG_ON(p4d_leaf(*p4d));
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page = __get_free_page(gfp);
 		if (WARN_ON_ONCE(!new_pud_page))

