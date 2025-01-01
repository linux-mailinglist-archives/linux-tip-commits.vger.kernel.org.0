Return-Path: <linux-tip-commits+bounces-3163-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAAA9FF3F7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 13:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC40B3A28DB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866431E2309;
	Wed,  1 Jan 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20Ho285C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/qiEKR5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA81E0DDF;
	Wed,  1 Jan 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735733659; cv=none; b=XyuhEQzUxe0N0OCulBT2RxDBvACHL9Uj7Drdir14tySYJO+qrjdKvg8igV0X0r32e5Tbic1BO/wfKIcqkd83tydurCybes4sqPWa6sbn/6y42raAHPQMGT6hnEYIYNoFIivIXrlb8xsNO/xlHQnxqZAw2fgytoqnSVQShOBCgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735733659; c=relaxed/simple;
	bh=cwwSqDrUN1z+Ymll4Km1SJ8YQZ/BreySIGt7Csz7Rt0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rz2wJhgA/t6cxa2HYPTpstCfXqXfe4qFDlmXUaiOXP2yW1TEUcqdGRMJtmgV3zcqFuQYKC5d+uLfesBzMSfJSI6q/4d0zOX+SZAQ3Kb3rwA3VL8QkXSbtv3gGRcI+GjhEtHJclsg93QD0ML13o+dq2yUk/ltZbSs66i1OAD116w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20Ho285C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/qiEKR5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 12:14:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735733656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmnetp3YV62wbjb4bR70ccwVNpcqpx2GHOfAy5EPzDk=;
	b=20Ho285CBEA69DYyl4zZEmZSyjkPj4RYSfKaCqwnjdEeHGbJkiINWZAN9KAnQEN1wre+0T
	bluHMUht/LBp4Y2y9KNUUwlcGovhSJ+fAaV7WbsUS/+7NuoWzx82q5A93s1nvg1Omp5nEh
	yiwLz1IhvdjW8rvi3C7AyqVyj1ncb0FbLVhNHvR92F4NwHmbk44sWlQ6/o0VQCmxfcg/x3
	139xTPcRyaANBnCsP5yplEVJmPDlN5TdwEznVSkuIdUYrqjmguwKc2uoTOdXFoiXe55jF4
	vxVg3kn7XUuKHCSOeYvDeejzS1UrPYHs4A3Umbc+5PFhh/okamDS14+oCI6EaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735733656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmnetp3YV62wbjb4bR70ccwVNpcqpx2GHOfAy5EPzDk=;
	b=w/qiEKR5ThY5FUHWR+kh8LGjFcle7lwRzpoqQPe8VPWUHMuXvli1Ag+Lo4hS/xCkew3OUd
	bMKLc6dhnGyhlTCw==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Make __verify_patch_size()
 return bool
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241018155151.702350-3-nik.borisov@suse.com>
References: <20241018155151.702350-3-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573365535.399.5755792214546617990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     d8317f3d8e6b412ff51ea66f1de2b2f89835f811
Gitweb:        https://git.kernel.org/tip/d8317f3d8e6b412ff51ea66f1de2b2f89835f811
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 18 Oct 2024 18:51:50 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 14:03:37 +01:00

x86/microcode/AMD: Make __verify_patch_size() return bool

The result of that function is in essence boolean, so simplify to return the
result of the relevant expression. It also makes it follow the convention used
by __verify_patch_section().

No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241018155151.702350-3-nik.borisov@suse.com
---
 arch/x86/kernel/cpu/microcode/amd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 95431e4..9a5ebbb 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -283,13 +283,13 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
  * exceed the per-family maximum). @sh_psize is the size read from the section
  * header.
  */
-static unsigned int __verify_patch_size(u32 sh_psize, size_t buf_size)
+static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
 {
 	u8 family = x86_family(bsp_cpuid_1_eax);
 	u32 max_size;
 
 	if (family >= 0x15)
-		return min_t(u32, sh_psize, buf_size);
+		goto ret;
 
 #define F1XH_MPB_MAX_SIZE 2048
 #define F14H_MPB_MAX_SIZE 1824
@@ -303,13 +303,15 @@ static unsigned int __verify_patch_size(u32 sh_psize, size_t buf_size)
 		break;
 	default:
 		WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
-		return 0;
+		return false;
 	}
 
-	if (sh_psize > min_t(u32, buf_size, max_size))
-		return 0;
+	if (sh_psize > max_size)
+		return false;
 
-	return sh_psize;
+ret:
+	/* Working with the whole buffer so < is ok. */
+	return sh_psize <= buf_size;
 }
 
 /*
@@ -324,7 +326,6 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 {
 	u8 family = x86_family(bsp_cpuid_1_eax);
 	struct microcode_header_amd *mc_hdr;
-	unsigned int ret;
 	u32 sh_psize;
 	u16 proc_id;
 	u8 patch_fam;
@@ -348,8 +349,7 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 		return -1;
 	}
 
-	ret = __verify_patch_size(sh_psize, buf_size);
-	if (!ret) {
+	if (!__verify_patch_size(sh_psize, buf_size)) {
 		pr_debug("Per-family patch size mismatch.\n");
 		return -1;
 	}

