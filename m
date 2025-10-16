Return-Path: <linux-tip-commits+bounces-6961-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C2BE59D6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 23:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0938A5E5B92
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680E2E426A;
	Thu, 16 Oct 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxsh1Hpt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UiEPN4T0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9642E62BE;
	Thu, 16 Oct 2025 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651604; cv=none; b=G62cmjs5TQsMnsSA32IaivZbCEX47Mg5BfTCqMjjSWbxok9rCrLoXPcMOBTv3AkPtL6frMj7QJqGoBeGkLMY57RwFWHS5875ceeFD84CWNe962ePSUMG2gNXUPKvH50zZuQ/x59dAZhFYamX4jiQsynh/dNpkV1BsDKiW2VMcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651604; c=relaxed/simple;
	bh=4XfhsPe71HOvfoKLrFaRgtPRINsI4RfNulG53/xATy8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J9HpJ4A3JT4WDk8KRm57Wtev4UwUYynuCvopMHL4BfZHOScoOOhFyIFY8vkk2QqDLAia61vOYm9907MPK/ITOSks3XhDhygJqjN9KllSYIbZ76by+Q9maQxN/pgclrFrfLG1SAhAxbFKJF6xXBJgznEztrX8k5HuAM27cB7Yev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxsh1Hpt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UiEPN4T0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 21:53:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760651601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3R1FWEUgQl4tJuXL7xEa/XFPiApTaFTleLxmgDbc7k=;
	b=kxsh1HptOl23O7KxJ9QYd7qPIGOzU31haS5X3sy740Uui7iNAkYoCv9q3pLsO5/SKCgMQA
	ESiPyizKkTYhVbrqc1hxfWSm3VYH73y2MMlJe59ZcD2d5wbj6FvOAgjKtBxvzUc6Dg1Zhr
	U7EJYj5vGQbUsqSMoamHzyLZiyjkqPGZhnnH7b1JBnmQ8q/lOYHQ/42Hn4eR9hKMvmgmtz
	2FBYFdvdAJYhk01fUZnApR87Z3QSvQlTmvxGy8VHnOrd5mZWPDfJ7DFwo2VmNohF7Ds9Yu
	bEqXsB4yAzNxZJY3prn1NMZmdffadSHp5pGHquRIls2dDylkzuLs09XImycMgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760651601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3R1FWEUgQl4tJuXL7xEa/XFPiApTaFTleLxmgDbc7k=;
	b=UiEPN4T0DPn1sxvmEC9YRpy2cI79DvDJIOT+wHJZKCGHuy8u396PCterDXKk+5dEEJhw82
	iEhr1UW1+XS0sQDQ==
From: "tip-bot2 for Elena Reshetova" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sgx] x86/sgx: Introduce functions to count the sgx_(vepc_)open()
Cc: Sean Christopherson <seanjc@google.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Nataliia Bondarevska <bondarn@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251016131314.17153-2-elena.reshetova@intel.com>
References: <20251016131314.17153-2-elena.reshetova@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176065160002.709179.1846480163550291641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     483fc19e9cb1256b6521266a3c62907f5912089a
Gitweb:        https://git.kernel.org/tip/483fc19e9cb1256b6521266a3c62907f591=
2089a
Author:        Elena Reshetova <elena.reshetova@intel.com>
AuthorDate:    Thu, 16 Oct 2025 16:11:04 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Oct 2025 14:42:08 -07:00

x86/sgx: Introduce functions to count the sgx_(vepc_)open()

Currently, when SGX is compromised and the microcode update fix is applied,
the machine needs to be rebooted to invalidate old SGX crypto-assets and
make SGX be in an updated safe state. It's not friendly for the cloud.

To avoid having to reboot, a new ENCLS[EUPDATESVN] is introduced to update
SGX environment at runtime. This process needs to be done when there's no
SGX users to make sure no compromised enclaves can survive from the update
and allow the system to regenerate crypto-assets.

For now there's no counter to track the active SGX users of host enclave
and virtual EPC. Introduce such counter mechanism so that the EUPDATESVN
can be done only when there's no SGX users.

Define placeholder functions sgx_inc/dec_usage_count() that are used to
increment and decrement such a counter. Also, wire the call sites for
these functions. Encapsulate the current sgx_(vepc_)open() to
__sgx_(vepc_)open() to make the new sgx_(vepc_)open() easy to read.

The definition of the counter itself and the actual implementation of
sgx_inc/dec_usage_count() functions come next.

Note: The EUPDATESVN, which may fail, will be done in
sgx_inc_usage_count(). Make it return 'int' to make subsequent patches
which implement EUPDATESVN easier to review. For now it always returns
success.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Nataliia Bondarevska <bondarn@google.com>
---
 arch/x86/kernel/cpu/sgx/driver.c | 19 ++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.c   |  1 +
 arch/x86/kernel/cpu/sgx/main.c   | 10 ++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h    |  3 +++
 arch/x86/kernel/cpu/sgx/virt.c   | 20 +++++++++++++++++++-
 5 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/drive=
r.c
index 7f8d1e1..79d6020 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -14,7 +14,7 @@ u64 sgx_attributes_reserved_mask;
 u64 sgx_xfrm_reserved_mask =3D ~0x3;
 u32 sgx_misc_reserved_mask;
=20
-static int sgx_open(struct inode *inode, struct file *file)
+static int __sgx_open(struct inode *inode, struct file *file)
 {
 	struct sgx_encl *encl;
 	int ret;
@@ -41,6 +41,23 @@ static int sgx_open(struct inode *inode, struct file *file)
 	return 0;
 }
=20
+static int sgx_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret =3D sgx_inc_usage_count();
+	if (ret)
+		return ret;
+
+	ret =3D __sgx_open(inode, file);
+	if (ret) {
+		sgx_dec_usage_count();
+		return ret;
+	}
+
+	return 0;
+}
+
 static int sgx_release(struct inode *inode, struct file *file)
 {
 	struct sgx_encl *encl =3D file->private_data;
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 308dbba..cf149b9 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -765,6 +765,7 @@ void sgx_encl_release(struct kref *ref)
 	WARN_ON_ONCE(encl->secs.epc_page);
=20
 	kfree(encl);
+	sgx_dec_usage_count();
 }
=20
 /*
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2de01b3..3a5cbd1 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -917,6 +917,16 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
=20
+int sgx_inc_usage_count(void)
+{
+	return 0;
+}
+
+void sgx_dec_usage_count(void)
+{
+	return;
+}
+
 static int __init sgx_init(void)
 {
 	int ret;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index d2dad21..f594039 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -102,6 +102,9 @@ static inline int __init sgx_vepc_init(void)
 }
 #endif
=20
+int sgx_inc_usage_count(void);
+void sgx_dec_usage_count(void);
+
 void sgx_update_lepubkeyhash(u64 *lepubkeyhash);
=20
 #endif /* _X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 7aaa365..b649c06 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -255,10 +255,11 @@ static int sgx_vepc_release(struct inode *inode, struct=
 file *file)
 	xa_destroy(&vepc->page_array);
 	kfree(vepc);
=20
+	sgx_dec_usage_count();
 	return 0;
 }
=20
-static int sgx_vepc_open(struct inode *inode, struct file *file)
+static int __sgx_vepc_open(struct inode *inode, struct file *file)
 {
 	struct sgx_vepc *vepc;
=20
@@ -273,6 +274,23 @@ static int sgx_vepc_open(struct inode *inode, struct fil=
e *file)
 	return 0;
 }
=20
+static int sgx_vepc_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret =3D sgx_inc_usage_count();
+	if (ret)
+		return ret;
+
+	ret =3D  __sgx_vepc_open(inode, file);
+	if (ret) {
+		sgx_dec_usage_count();
+		return ret;
+	}
+
+	return 0;
+}
+
 static long sgx_vepc_ioctl(struct file *file,
 			   unsigned int cmd, unsigned long arg)
 {

