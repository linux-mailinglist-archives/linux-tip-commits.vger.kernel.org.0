Return-Path: <linux-tip-commits+bounces-6679-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6CBB84956
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 14:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547C56203C1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F4D2FDC59;
	Thu, 18 Sep 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBuT6aB5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGGnd1K0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE12DF6E6;
	Thu, 18 Sep 2025 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198596; cv=none; b=W2LtcL9bMjCp6aJi/3GrHYImLFeTEImclmm6aaar7g2vTMvEO0FQhMQlrVFDNZ9RsT7QdyE3EjIFO03SSlJoVntcAc/gKkBIAGdr8KHs5JTdYfykhKgtVE/1nIKMueimbYuwsp9Plw+7IGhq4jPN2PDyfVuRlfgberppsw9fXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198596; c=relaxed/simple;
	bh=2kO8w1GpMEKiifCYsUi+iokOxGR7VDVZiIFwloRG7K8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mg0Kuq3usymYjy8W506W1atwTfZBT+OPn/5myJtHgAjFtpo1tOnbQKRzy5nVP5kdIS8Ir/cl6bWtGm0X7/SaU3fwEFxiI0z0oJYgpNnMi7dIpJ1IRIkH1WEcMuFrkgjFq7MtOlaW/DRLFVim77pA55z1MO4Lv86vbJgH+ICLIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBuT6aB5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGGnd1K0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 12:29:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758198592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XmR1cQT8xWO6ZjN6NRSH6N69m1wD7nrEWYgNwL623k=;
	b=jBuT6aB5NOLhZ+Okg7IIX/W9A2eWEd74vYAUbCdVKY/Jlu7IbgEBl9ubLTRSTxT6AbLw1a
	2JITsFLgQjEDcdkRufj/Af9tGMZJFJPzXI12MrrAGB3fIO5zPjP5v6j3LudQYEviy0lEiu
	rmGKOqRqX3zLT84oo7rWwppQBXDGMAlMHjwiOmllbBxgXn4fYV/WyLKG1iS0ke+Jw4Hmxn
	YMI39q8uYS7kTT4Gdhpa0NZC0hgDH620kQgeRzAedRlXmgLZyrME5fJhN8RJMkGBG754HD
	o5ypz7E29vSgcoZzZCDa7EnJsSr0/69K3TunWxRPt0jhMoHuvGUlQVZDYfkE4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758198592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XmR1cQT8xWO6ZjN6NRSH6N69m1wD7nrEWYgNwL623k=;
	b=BGGnd1K0Ipfmw4rZuvUbGwPP+VtgNVN8KrlCNrlEC1N07njWpKEPLHdRlVW5r7jH4g/VUj
	Pz8l6ndK4aB027DA==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] crypto: ccp - Add new HV-Fixed page allocation/free API
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cea9dc045267d0e5925476e0410914e3a5da4e3e0=2E1758057?=
 =?utf-8?q?691=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cea9dc045267d0e5925476e0410914e3a5da4e3e0=2E17580576?=
 =?utf-8?q?91=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175819859165.709179.18339759124515377467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e09701dcdd9ca06be249091eeb786d57e67b613e
Gitweb:        https://git.kernel.org/tip/e09701dcdd9ca06be249091eeb786d57e67=
b613e
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Tue, 16 Sep 2025 21:29:33=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 17 Sep 2025 12:11:39 +02:00

crypto: ccp - Add new HV-Fixed page allocation/free API

When SEV-SNP is active, the TEE extended command header page and all output
buffers for TEE extended commands (such as used by Seamless Firmware servicing
support) must be in hypervisor-fixed state, assigned to the hypervisor and
marked immutable in the RMP entrie(s).

Add a new generic SEV API interface to allocate/free hypervisor fixed pages
which abstracts hypervisor fixed page allocation/free for PSP sub devices. The
API internally uses SNP_INIT_EX to transition pages to HV-Fixed page state.

If SNP is not enabled then the allocator is simply a wrapper over
alloc_pages() and __free_pages().

When the sub device free the pages, they are put on a free list and future
allocation requests will try to re-use the freed pages from this list. But
this list is not preserved across PSP driver load/unload hence this free/reuse
support is only supported while PSP driver is loaded. As HV_FIXED page state
is only changed at reboot, these pages are leaked as they cannot be returned
back to the page allocator and then potentially allocated to guests, which
will cause SEV-SNP guests to fail to start or terminate when accessing the
HV_FIXED page.

Suggested-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/cover.1758057691.git.ashish.kalra@amd.com
---
 drivers/crypto/ccp/sev-dev.c | 182 ++++++++++++++++++++++++++++++++++-
 drivers/crypto/ccp/sev-dev.h |   3 +-
 2 files changed, 185 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e058ba0..f7b9c65 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -82,6 +82,21 @@ MODULE_FIRMWARE("amd/amd_sev_fam19h_model1xh.sbin"); /* 4t=
h gen EPYC */
 static bool psp_dead;
 static int psp_timeout;
=20
+enum snp_hv_fixed_pages_state {
+	ALLOCATED,
+	HV_FIXED,
+};
+
+struct snp_hv_fixed_pages_entry {
+	struct list_head list;
+	struct page *page;
+	unsigned int order;
+	bool free;
+	enum snp_hv_fixed_pages_state page_state;
+};
+
+static LIST_HEAD(snp_hv_fixed_pages);
+
 /* Trusted Memory Region (TMR):
  *   The TMR is a 1MB area that must be 1MB aligned.  Use the page allocator
  *   to allocate the memory, which will return aligned memory for the specif=
ied
@@ -1073,6 +1088,165 @@ static void snp_set_hsave_pa(void *arg)
 	wrmsrq(MSR_VM_HSAVE_PA, 0);
 }
=20
+/* Hypervisor Fixed pages API interface */
+static void snp_hv_fixed_pages_state_update(struct sev_device *sev,
+					    enum snp_hv_fixed_pages_state page_state)
+{
+	struct snp_hv_fixed_pages_entry *entry;
+
+	/* List is protected by sev_cmd_mutex */
+	lockdep_assert_held(&sev_cmd_mutex);
+
+	if (list_empty(&snp_hv_fixed_pages))
+		return;
+
+	list_for_each_entry(entry, &snp_hv_fixed_pages, list)
+		entry->page_state =3D page_state;
+}
+
+/*
+ * Allocate HV_FIXED pages in 2MB aligned sizes to ensure the whole
+ * 2MB pages are marked as HV_FIXED.
+ */
+struct page *snp_alloc_hv_fixed_pages(unsigned int num_2mb_pages)
+{
+	struct psp_device *psp_master =3D psp_get_master_device();
+	struct snp_hv_fixed_pages_entry *entry;
+	struct sev_device *sev;
+	unsigned int order;
+	struct page *page;
+
+	if (!psp_master || !psp_master->sev_data)
+		return NULL;
+
+	sev =3D psp_master->sev_data;
+
+	order =3D get_order(PMD_SIZE * num_2mb_pages);
+
+	/*
+	 * SNP_INIT_EX is protected by sev_cmd_mutex, therefore this list
+	 * also needs to be protected using the same mutex.
+	 */
+	guard(mutex)(&sev_cmd_mutex);
+
+	/*
+	 * This API uses SNP_INIT_EX to transition allocated pages to HV_Fixed
+	 * page state, fail if SNP is already initialized.
+	 */
+	if (sev->snp_initialized)
+		return NULL;
+
+	/* Re-use freed pages that match the request */
+	list_for_each_entry(entry, &snp_hv_fixed_pages, list) {
+		/* Hypervisor fixed page allocator implements exact fit policy */
+		if (entry->order =3D=3D order && entry->free) {
+			entry->free =3D false;
+			memset(page_address(entry->page), 0,
+			       (1 << entry->order) * PAGE_SIZE);
+			return entry->page;
+		}
+	}
+
+	page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!page)
+		return NULL;
+
+	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		__free_pages(page, order);
+		return NULL;
+	}
+
+	entry->page =3D page;
+	entry->order =3D order;
+	list_add_tail(&entry->list, &snp_hv_fixed_pages);
+
+	return page;
+}
+
+void snp_free_hv_fixed_pages(struct page *page)
+{
+	struct psp_device *psp_master =3D psp_get_master_device();
+	struct snp_hv_fixed_pages_entry *entry, *nentry;
+
+	if (!psp_master || !psp_master->sev_data)
+		return;
+
+	/*
+	 * SNP_INIT_EX is protected by sev_cmd_mutex, therefore this list
+	 * also needs to be protected using the same mutex.
+	 */
+	guard(mutex)(&sev_cmd_mutex);
+
+	list_for_each_entry_safe(entry, nentry, &snp_hv_fixed_pages, list) {
+		if (entry->page !=3D page)
+			continue;
+
+		/*
+		 * HV_FIXED page state cannot be changed until reboot
+		 * and they cannot be used by an SNP guest, so they cannot
+		 * be returned back to the page allocator.
+		 * Mark the pages as free internally to allow possible re-use.
+		 */
+		if (entry->page_state =3D=3D HV_FIXED) {
+			entry->free =3D true;
+		} else {
+			__free_pages(page, entry->order);
+			list_del(&entry->list);
+			kfree(entry);
+		}
+		return;
+	}
+}
+
+static void snp_add_hv_fixed_pages(struct sev_device *sev, struct sev_data_r=
ange_list *range_list)
+{
+	struct snp_hv_fixed_pages_entry *entry;
+	struct sev_data_range *range;
+	int num_elements;
+
+	lockdep_assert_held(&sev_cmd_mutex);
+
+	if (list_empty(&snp_hv_fixed_pages))
+		return;
+
+	num_elements =3D list_count_nodes(&snp_hv_fixed_pages) +
+		       range_list->num_elements;
+
+	/*
+	 * Ensure the list of HV_FIXED pages that will be passed to firmware
+	 * do not exceed the page-sized argument buffer.
+	 */
+	if (num_elements * sizeof(*range) + sizeof(*range_list) > PAGE_SIZE) {
+		dev_warn(sev->dev, "Additional HV_Fixed pages cannot be accommodated, omit=
ting\n");
+		return;
+	}
+
+	range =3D &range_list->ranges[range_list->num_elements];
+	list_for_each_entry(entry, &snp_hv_fixed_pages, list) {
+		range->base =3D page_to_pfn(entry->page) << PAGE_SHIFT;
+		range->page_count =3D 1 << entry->order;
+		range++;
+	}
+	range_list->num_elements =3D num_elements;
+}
+
+static void snp_leak_hv_fixed_pages(void)
+{
+	struct snp_hv_fixed_pages_entry *entry;
+
+	/* List is protected by sev_cmd_mutex */
+	lockdep_assert_held(&sev_cmd_mutex);
+
+	if (list_empty(&snp_hv_fixed_pages))
+		return;
+
+	list_for_each_entry(entry, &snp_hv_fixed_pages, list)
+		if (entry->page_state =3D=3D HV_FIXED)
+			__snp_leak_pages(page_to_pfn(entry->page),
+					 1 << entry->order, false);
+}
+
 static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
 {
 	struct sev_data_range_list *range_list =3D arg;
@@ -1163,6 +1337,12 @@ static int __sev_snp_init_locked(int *error)
 			return rc;
 		}
=20
+		/*
+		 * Add HV_Fixed pages from other PSP sub-devices, such as SFS to the
+		 * HV_Fixed page list.
+		 */
+		snp_add_hv_fixed_pages(sev, snp_range_list);
+
 		memset(&data, 0, sizeof(data));
 		data.init_rmp =3D 1;
 		data.list_paddr_en =3D 1;
@@ -1202,6 +1382,7 @@ static int __sev_snp_init_locked(int *error)
 		return rc;
 	}
=20
+	snp_hv_fixed_pages_state_update(sev, HV_FIXED);
 	sev->snp_initialized =3D true;
 	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
=20
@@ -1784,6 +1965,7 @@ static int __sev_snp_shutdown_locked(int *error, bool p=
anic)
 		return ret;
 	}
=20
+	snp_leak_hv_fixed_pages();
 	sev->snp_initialized =3D false;
 	dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
=20
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 3e4e557..28021ab 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -65,4 +65,7 @@ void sev_dev_destroy(struct psp_device *psp);
 void sev_pci_init(void);
 void sev_pci_exit(void);
=20
+struct page *snp_alloc_hv_fixed_pages(unsigned int num_2mb_pages);
+void snp_free_hv_fixed_pages(struct page *page);
+
 #endif /* __SEV_DEV_H */

