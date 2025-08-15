Return-Path: <linux-tip-commits+bounces-6250-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21084B27C67
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 11:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207651D06169
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E92E265E;
	Fri, 15 Aug 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSOxTuLd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mbIOxlwv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8592DCF60;
	Fri, 15 Aug 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248722; cv=none; b=WowTjVRP0LL1X1273FyJWe2+sKGZaW3HT/C5moIUPK6dLa4r0vrs5BN2kADfxYCUUZ8T0HTSmwv/9+qH/xKAQNwnn9gxIul3aWyOF1eL6PYPl3ZpZgDzLgPAchtlNUStpaEFaZH5hQRc4d1rp/+YIA6LacQQ7CxOr2mBW85dKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248722; c=relaxed/simple;
	bh=9rGFE7kqsbowEhDsZAifbWOaYU2ubO9Rg2SpSVzyIlk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jGVf8Z1hDAhOkMPlKDOkoffB3pWvqcjuJqYxiQqEn0YozTDoWKAlzDjAEqlJQH3gdpF6NjPb996ZIX0cuRNgCeSxCB6D+kY02YdO//XsNTniX/y/R9dx/hzFr8xhsrUzZlYANtvcxVqJn4wPbHRe5mjPr9CXgfTsQpOD7he3EYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sSOxTuLd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mbIOxlwv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Aug 2025 09:05:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755248717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00XaF3NhAN+6fMS8G1nY4QZ/ll3bKjnEZFC8D7o7GOg=;
	b=sSOxTuLdhUPyYXoX8608gYmQRw0hpRSmi+Bcfj69c1R3DBwuANlHHYZ4D0J+TdPryv6wbL
	EFrUyi87R3XCc7tmnnvP+i6q5B+S1s+aKKk+7eHbvpgrM5gZW744Qq5IUto43wsoZMhWKn
	V5Xj8RFJkPjXZAacHkM0IUV9q9+lqOAg6Lmn1JffJVV/Hq+gvUwN/F9jf0DWrJlqRuNt4S
	7KIce1P5PM643yQZ7Qcp/Ev/PMMIEQHJWiIddBgQjG2riHlnQpRKgJSoURnSk6JqAG6eLU
	i2E1WkMfIb+Ltl4NNx8/a4LXLK84OzwFjxlXPdXAKHZ5+KydA7k3f/bFz8YKjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755248717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00XaF3NhAN+6fMS8G1nY4QZ/ll3bKjnEZFC8D7o7GOg=;
	b=mbIOxlwvTueg/68lfuNN604ESWYE6MjWXeR/Umw7EfuZ8/ErcmqaUK/HLczRyhs3qhh61o
	x2EngQLuHFkwIuCw==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Ensure SVSM reserved fields in a page
 validation entry are initialized to zero
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Joerg Roedel <joerg.roedel@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7cde412f8b057ea13a646fb166b1ca023f6a5031=2E1755098?=
 =?utf-8?q?819=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C7cde412f8b057ea13a646fb166b1ca023f6a5031=2E17550988?=
 =?utf-8?q?19=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175524871566.1420.6970992850866287220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d3be079da81f08d8d7f3416119b03e173d4285d2
Gitweb:        https://git.kernel.org/tip/d3be079da81f08d8d7f3416119b03e173d4=
285d2
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 13 Aug 2025 10:26:59 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Aug 2025 10:50:01 +02:00

x86/sev: Ensure SVSM reserved fields in a page validation entry are initializ=
ed to zero

In order to support future versions of the SVSM_CORE_PVALIDATE call, all
reserved fields within a PVALIDATE entry must be set to zero as an SVSM should
be ensuring all reserved fields are zero in order to support future usage of
reserved areas based on the protocol version.

Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at V=
MPL0")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Joerg Roedel <joerg.roedel@amd.com>
Link: https://lore.kernel.org/7cde412f8b057ea13a646fb166b1ca023f6a5031.175509=
8819.git.thomas.lendacky@amd.com
---
 arch/x86/boot/startup/sev-shared.c | 1 +
 arch/x86/coco/sev/core.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 7a706db..4ab0dbd 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -785,6 +785,7 @@ static void __head svsm_pval_4k_page(unsigned long paddr,=
 bool validate)
 	pc->entry[0].page_size =3D RMP_PG_SIZE_4K;
 	pc->entry[0].action    =3D validate;
 	pc->entry[0].ignore_cf =3D 0;
+	pc->entry[0].rsvd      =3D 0;
 	pc->entry[0].pfn       =3D paddr >> PAGE_SHIFT;
=20
 	/* Protocol 0, Call ID 1 */
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index fc59ce7..43ecc6b 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -227,6 +227,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_=
end, bool action,
 		pe->page_size =3D RMP_PG_SIZE_4K;
 		pe->action    =3D action;
 		pe->ignore_cf =3D 0;
+		pe->rsvd      =3D 0;
 		pe->pfn       =3D pfn;
=20
 		pe++;
@@ -257,6 +258,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_des=
c *desc, unsigned int d
 		pe->page_size =3D e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		pe->action    =3D e->operation =3D=3D SNP_PAGE_STATE_PRIVATE;
 		pe->ignore_cf =3D 0;
+		pe->rsvd      =3D 0;
 		pe->pfn       =3D e->gfn;
=20
 		pe++;

