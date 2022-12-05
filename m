Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683DB643721
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Dec 2022 22:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiLEVmw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Dec 2022 16:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiLEVlx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5973B2CDDE;
        Mon,  5 Dec 2022 13:41:52 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QIIZask/7dqALbTfrzb2zd5IUkxQ4S0WwzWXK8noBw=;
        b=4ubavhbg7t1CmgEb5OKVFdV/2k+P+LFnZjR5O4tB8+UhZQNjwW+f1bKfC305ERCL3nMlmO
        p40fDfI4+NXnOV3EqllL4Y44FDjM6VvdbvP+khV8foqg/EUEvr/flZR+0HhnQQ5rStJoqF
        gC18uWvVBWnGMrln5EqTDPWMTvhFh60w0/E0psBn1qIDKDYhNlFPNc3dMMGQthdA/ko9ax
        kI8wRhQZcksy89r6SNgBMf9MzhT/P10Nz7jyw3xhPDz1bAVmVrF85XBfmmmFGZ+3A9a12j
        Z3tCauLkPtdFBtjLUnafk58olO3CDtag3MZ+CMCgjQ8WQG9VF9v5l5jPBLMUVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QIIZask/7dqALbTfrzb2zd5IUkxQ4S0WwzWXK8noBw=;
        b=DWUOXnH3rKTxYGcXUxO+bBIlOtJprCMOot4Xsn7IE4xGumP9quPNEjVxTMHpuH5qQrlp/N
        kGr0sgeEEG6NspBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide msi_desc:: Msi_data
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.385036043@linutronix.de>
References: <20221124232326.385036043@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650840.4906.7820619670349012822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     efd42049657e958797a483f793e4064042faa49c
Gitweb:        https://git.kernel.org/tip/efd42049657e958797a483f793e4064042faa49c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:33 +01:00

genirq/msi: Provide msi_desc:: Msi_data

The upcoming support for PCI/IMS requires to store some information related
to the message handling in the MSI descriptor, e.g. PASID or a pointer to a
queue.

Provide a generic storage struct which maps over the existing PCI specific
storage which means the size of struct msi_desc is not getting bigger.

This storage struct has two elements:

  1) msi_domain_cookie
  2) msi_instance_cookie

The domain cookie is going to be used to store domain specific information,
e.g. iobase pointer, data pointer.

The instance cookie is going to be handed in when allocating an interrupt
on an IMS domain so the irq chip callbacks of the IMS domain have the
necessary per vector information available. It also comes in handy when
cleaning up the platform MSI code for wire to MSI bridges which need to
hand down the type information to the underlying interrupt domain.

For the core code the cookies are opaque and meaningless. It just stores
the instance cookie during an allocation through the upcoming interfaces
for IMS and wire to MSI brigdes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.385036043@linutronix.de

---
 include/linux/msi.h     | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/msi_api.h | 17 +++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index b5dda4b..dca3b80 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -125,6 +125,38 @@ struct pci_msi_desc {
 	};
 };
 
+/**
+ * union msi_domain_cookie - Opaque MSI domain specific data
+ * @value:	u64 value store
+ * @ptr:	Pointer to domain specific data
+ * @iobase:	Domain specific IOmem pointer
+ *
+ * The content of this data is implementation defined and used by the MSI
+ * domain to store domain specific information which is requried for
+ * interrupt chip callbacks.
+ */
+union msi_domain_cookie {
+	u64	value;
+	void	*ptr;
+	void	__iomem *iobase;
+};
+
+/**
+ * struct msi_desc_data - Generic MSI descriptor data
+ * @dcookie:	Cookie for MSI domain specific data which is required
+ *		for irq_chip callbacks
+ * @icookie:	Cookie for the MSI interrupt instance provided by
+ *		the usage site to the allocation function
+ *
+ * The content of this data is implementation defined, e.g. PCI/IMS
+ * implementations define the meaning of the data. The MSI core ignores
+ * this data completely.
+ */
+struct msi_desc_data {
+	union msi_domain_cookie		dcookie;
+	union msi_instance_cookie	icookie;
+};
+
 #define MSI_MAX_INDEX		((unsigned int)USHRT_MAX)
 
 /**
@@ -142,6 +174,7 @@ struct pci_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	PCI specific msi descriptor data
+ * @data:	Generic MSI descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -161,7 +194,10 @@ struct msi_desc {
 	void *write_msi_msg_data;
 
 	u16				msi_index;
-	struct pci_msi_desc		pci;
+	union {
+		struct pci_msi_desc	pci;
+		struct msi_desc_data	data;
+	};
 };
 
 /*
diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
index 4cb7f4c..2e4456e 100644
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -19,6 +19,23 @@ enum msi_domain_ids {
 };
 
 /**
+ * union msi_instance_cookie - MSI instance cookie
+ * @value:	u64 value store
+ * @ptr:	Pointer to usage site specific data
+ *
+ * This cookie is handed to the IMS allocation function and stored in the
+ * MSI descriptor for the interrupt chip callbacks.
+ *
+ * The content of this cookie is MSI domain implementation defined.  For
+ * PCI/IMS implementations this could be a PASID or a pointer to queue
+ * memory.
+ */
+union msi_instance_cookie {
+	u64	value;
+	void	*ptr;
+};
+
+/**
  * msi_map - Mapping between MSI index and Linux interrupt number
  * @index:	The MSI index, e.g. slot in the MSI-X table or
  *		a software managed index if >= 0. If negative
