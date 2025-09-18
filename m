Return-Path: <linux-tip-commits+bounces-6680-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB8B84959
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8387C177A2E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581302FFF85;
	Thu, 18 Sep 2025 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7Tucm1I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PGU66vsw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A32FCC1B;
	Thu, 18 Sep 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198597; cv=none; b=iEzaXJsy0mPUrV0CgYjHm8A8mN+BKIW8+IQiNpm/ADcfEZTjrYRwfjyZk7W7Zzyh6WJWjL09yzsKjtfNXfkIGapnySwnaEHOOu5tYIgE8ziCE+GxGAiWV3agYbwzieJ38t0j/2nZhFBdyLcToF1DKbEOzhegq6Dc7Tgh6PdMWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198597; c=relaxed/simple;
	bh=JlcK1wKX+MmXMMpADMdXw6z2dEW6fsAaNiYPNZlh/ME=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HeGMY0CiC9xCdY1aDfxqEu2oBFr51+3ymUroyMrFJrdKUoYH+/S8pXQOIWNs8TWrnPNL3MYbCQ3ZOfAe6UDHXIaPZ6E1HK+N0yT5frEuVm/vd3vQjMn0WNI2O/Xn9eFaZnWMGt/t29z1b/hI4eEYDHLdlRbTqOllf1MNJKD0YXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7Tucm1I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PGU66vsw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 12:29:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758198594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3qInEUWT5s8CFhcXjmURjBXAVx05XweOk52wSZbCao=;
	b=m7Tucm1IgbLsK9j55C7SWnyIystsV4D3BhqnfSGL31mfrz07Bt5tIIuxmiiArC52AgnBMV
	HBBrDJ6JwmRz1OHZVqYvrDjcMq2LOTvqKsp3g8dnsloQephvQ5ZCtbNTnw5B550MExTC1A
	rBkM2qFvsw6idtODHjaWjBsu2cZoecLAZEE8HQEmUX8EOqEd6ro/+IstaRc6Wfo1TjYr/8
	Rwsv0b3DEBua7x20i1ZpZ2oIqmCRuDcFRnlFCUKfO1SKHLzZtGvna+NhYBL05v6PJK6em+
	n9tDwDRwkCkt0z+dA+sWFbD2YvhQzXB0MVGanoLDv0tSSBY75RJHyQdlp93sRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758198594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3qInEUWT5s8CFhcXjmURjBXAVx05XweOk52wSZbCao=;
	b=PGU66vswmQjCfHl1CKYUaiTQ5vlCfgRkt//i321dNjMonX30soT5MJq1l56qnBWChg+odC
	Qhk3zpv4ogTSKnBg==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/sev: Add new dump_rmp parameter to snp_leak_pages() API
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>,
 Sean Christopherson <seanjc@google.com>, Ashish Kalra <ashish.kalra@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cff513f8fcf28a075f906a4ea8bacd92de225556d=2E1758057?=
 =?utf-8?q?691=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cff513f8fcf28a075f906a4ea8bacd92de225556d=2E17580576?=
 =?utf-8?q?91=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175819859276.709179.1414166363314403390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e4c00c4ce2aafe61dc7436e763a78d6d112d9e2f
Gitweb:        https://git.kernel.org/tip/e4c00c4ce2aafe61dc7436e763a78d6d112=
d9e2f
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Tue, 16 Sep 2025 21:29:04=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 17 Sep 2025 12:04:04 +02:00

x86/sev: Add new dump_rmp parameter to snp_leak_pages() API

When leaking certain page types, such as Hypervisor Fixed (HV_FIXED)
pages, it does not make sense to dump RMP contents for the 2MB range of
the page(s) being leaked. In the case of HV_FIXED pages, this is not an
error situation where the surrounding 2MB page RMP entries can provide
debug information.

Add new __snp_leak_pages() API with dump_rmp bool parameter to support
continue adding pages to the snp_leaked_pages_list but not issue
dump_rmpentry().

Make snp_leak_pages() a wrapper for the common case which also allows
existing users to continue to dump RMP entries.

Suggested-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/cover.1758057691.git.ashish.kalra@amd.com
---
 arch/x86/include/asm/sev.h | 7 ++++++-
 arch/x86/virt/svm/sev.c    | 7 ++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 44dae74..f9046c4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -655,9 +655,13 @@ void snp_dump_hva_rmpentry(unsigned long address);
 int psmash(u64 pfn);
 int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool i=
mmutable);
 int rmp_make_shared(u64 pfn, enum pg_level level);
-void snp_leak_pages(u64 pfn, unsigned int npages);
+void __snp_leak_pages(u64 pfn, unsigned int npages, bool dump_rmp);
 void kdump_sev_callback(void);
 void snp_fixup_e820_tables(void);
+static inline void snp_leak_pages(u64 pfn, unsigned int pages)
+{
+	__snp_leak_pages(pfn, pages, true);
+}
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_rmptable_init(void) { return -ENOSYS; }
@@ -670,6 +674,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum=
 pg_level level, u32 as
 	return -ENODEV;
 }
 static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -EN=
ODEV; }
+static inline void __snp_leak_pages(u64 pfn, unsigned int npages, bool dump_=
rmp) {}
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
 static inline void snp_fixup_e820_tables(void) {}
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 942372e..ee643a6 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -1029,7 +1029,7 @@ int rmp_make_shared(u64 pfn, enum pg_level level)
 }
 EXPORT_SYMBOL_GPL(rmp_make_shared);
=20
-void snp_leak_pages(u64 pfn, unsigned int npages)
+void __snp_leak_pages(u64 pfn, unsigned int npages, bool dump_rmp)
 {
 	struct page *page =3D pfn_to_page(pfn);
=20
@@ -1052,14 +1052,15 @@ void snp_leak_pages(u64 pfn, unsigned int npages)
 		    (PageHead(page) && compound_nr(page) <=3D npages))
 			list_add_tail(&page->buddy_list, &snp_leaked_pages_list);
=20
-		dump_rmpentry(pfn);
+		if (dump_rmp)
+			dump_rmpentry(pfn);
 		snp_nr_leaked_pages++;
 		pfn++;
 		page++;
 	}
 	spin_unlock(&snp_leaked_pages_list_lock);
 }
-EXPORT_SYMBOL_GPL(snp_leak_pages);
+EXPORT_SYMBOL_GPL(__snp_leak_pages);
=20
 void kdump_sev_callback(void)
 {

