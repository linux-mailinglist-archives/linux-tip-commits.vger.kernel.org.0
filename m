Return-Path: <linux-tip-commits+bounces-1750-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC493EFD8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F00284127
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC213A3FF;
	Mon, 29 Jul 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gp6ZWU2p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVqlgukZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A0130A7D;
	Mon, 29 Jul 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241522; cv=none; b=BQyUIs4i3ifKijOAiIxImvpA/j50h1Kogt1DyF3aydnVyHqDVVGzec9wpvlwfZaM6hI+SCzWnESREu/l0dOrEmch789yUHYXM5u1dwE75qpM9z4KKB9Su51GLO7rJg9cYBmBlISgQM3TxTsKtzW1ifUlrzBcOn3H5K1aSa1lKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241522; c=relaxed/simple;
	bh=fN4O4SOjTL8xor3PQZ0GftxaSEARkfGZIerv6btFL7c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ED0MktCXEdacQFBf1kVIWq3HOIh/hnVV+L3n5I+ofE+r4YluDZTEWmCCQ636jTam9s0LUmqtOuc0UbzbUh0AkedXlBU6HbDMiiusoXn8CAUqK5DXPZTdrBKg1xw0v3wKQVfvutfZu2eb9ioKfMotI72hOzxTzoMpNKquc7Fhzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gp6ZWU2p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVqlgukZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 08:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722241518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8mvZWPjAmCF9jv/z4Csp++h/d+k6pxEfOnejvuY3VQ=;
	b=Gp6ZWU2pRM++wQ7VELjml3Hz+kjZvQ6fXTDeYdA2kfaDkuKw8lCCqbrkDpz1q2dCyELteY
	Brgfc2m50oiIDo9YU53HA43ZUHo0FTtrG45UvV1Uyx8/Z/AOJQwi35KixGtkNuBo0tyCX5
	vXguIOHKEsaGL1TtDzHaGrGXx9dItLpdUHPscVc31LYtvhTIXdbeIqMjDvWrDAemAbdnSz
	XMzK9xGMDmUzULTmg6inWE2vLSLBjBj34LSSlU6XZdrNcnNBOIpRGgMDUbGbaaW8r9qeFy
	VSs8IPF2K4j1RKpvVvMSS06JwWiyKLVPNOR3gMu8uIDiQTYM6E1a/YjI093nxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722241518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8mvZWPjAmCF9jv/z4Csp++h/d+k6pxEfOnejvuY3VQ=;
	b=XVqlgukZzlDN5PKkkWXijMEm14vApOpROm2w4X7mcRexW/NeBa9YV9M9wxOWLtnJhtdknc
	mvfKjreW7WkQcsCA==
From: "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Use the family,model,stepping
 encoded in the patch ID
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240725112037.GBZqI1BbUk1KMlOJ_D@fat_crate.local>
References: <20240725112037.GBZqI1BbUk1KMlOJ_D@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224151743.2215.18292562032399010255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     94838d230a6c835ced1bad06b8759e0a5f19c1d3
Gitweb:        https://git.kernel.org/tip/94838d230a6c835ced1bad06b8759e0a5f19c1d3
Author:        Borislav Petkov <bp@alien8.de>
AuthorDate:    Thu, 25 Jul 2024 13:20:37 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jul 2024 09:21:26 +02:00

x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID

On Zen and newer, the family, model and stepping is part of the
microcode patch ID so that the equivalence table the driver has been
using, is not needed anymore.

So switch the driver to use that from now on.

The equivalence table in the microcode blob should still remain in case
there's need to pass some additional information to the kernel loader.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240725112037.GBZqI1BbUk1KMlOJ_D@fat_crate.local
---
 arch/x86/kernel/cpu/microcode/amd.c | 190 ++++++++++++++++++++++-----
 1 file changed, 158 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index c0d56c0..1f5d36f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -89,6 +89,31 @@ static struct equiv_cpu_table {
 	struct equiv_cpu_entry *entry;
 } equiv_table;
 
+union zen_patch_rev {
+	struct {
+		__u32 rev	 : 8,
+		      stepping	 : 4,
+		      model	 : 4,
+		      __reserved : 4,
+		      ext_model	 : 4,
+		      ext_fam	 : 8;
+	};
+	__u32 ucode_rev;
+};
+
+union cpuid_1_eax {
+	struct {
+		__u32 stepping    : 4,
+		      model	  : 4,
+		      family	  : 4,
+		      __reserved0 : 4,
+		      ext_model   : 4,
+		      ext_fam     : 8,
+		      __reserved1 : 4;
+	};
+	__u32 full;
+};
+
 /*
  * This points to the current valid container of microcode patches which we will
  * save from the initrd/builtin before jettisoning its contents. @mc is the
@@ -96,7 +121,6 @@ static struct equiv_cpu_table {
  */
 struct cont_desc {
 	struct microcode_amd *mc;
-	u32		     cpuid_1_eax;
 	u32		     psize;
 	u8		     *data;
 	size_t		     size;
@@ -109,10 +133,42 @@ struct cont_desc {
 static const char
 ucode_path[] __maybe_unused = "kernel/x86/microcode/AuthenticAMD.bin";
 
+/*
+ * This is CPUID(1).EAX on the BSP. It is used in two ways:
+ *
+ * 1. To ignore the equivalence table on Zen1 and newer.
+ *
+ * 2. To match which patches to load because the patch revision ID
+ *    already contains the f/m/s for which the microcode is destined
+ *    for.
+ */
+static u32 bsp_cpuid_1_eax __ro_after_init;
+
+static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
+{
+	union zen_patch_rev p;
+	union cpuid_1_eax c;
+
+	p.ucode_rev = val;
+	c.full = 0;
+
+	c.stepping  = p.stepping;
+	c.model     = p.model;
+	c.ext_model = p.ext_model;
+	c.family    = 0xf;
+	c.ext_fam   = p.ext_fam;
+
+	return c;
+}
+
 static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 {
 	unsigned int i;
 
+	/* Zen and newer do not need an equivalence table. */
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		return 0;
+
 	if (!et || !et->num_entries)
 		return 0;
 
@@ -159,6 +215,10 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
 	if (!verify_container(buf, buf_size))
 		return false;
 
+	/* Zen and newer do not need an equivalence table. */
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		return true;
+
 	cont_type = hdr[1];
 	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
 		pr_debug("Wrong microcode container equivalence table type: %u.\n",
@@ -222,8 +282,9 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
  * exceed the per-family maximum). @sh_psize is the size read from the section
  * header.
  */
-static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size)
+static unsigned int __verify_patch_size(u32 sh_psize, size_t buf_size)
 {
+	u8 family = x86_family(bsp_cpuid_1_eax);
 	u32 max_size;
 
 	if (family >= 0x15)
@@ -258,9 +319,9 @@ static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size
  * positive: patch is not for this family, skip it
  * 0: success
  */
-static int
-verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size)
+static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 {
+	u8 family = x86_family(bsp_cpuid_1_eax);
 	struct microcode_header_amd *mc_hdr;
 	unsigned int ret;
 	u32 sh_psize;
@@ -286,7 +347,7 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size)
 		return -1;
 	}
 
-	ret = __verify_patch_size(family, sh_psize, buf_size);
+	ret = __verify_patch_size(sh_psize, buf_size);
 	if (!ret) {
 		pr_debug("Per-family patch size mismatch.\n");
 		return -1;
@@ -308,6 +369,15 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size)
 	return 0;
 }
 
+static bool mc_patch_matches(struct microcode_amd *mc, u16 eq_id)
+{
+	/* Zen and newer do not need an equivalence table. */
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		return ucode_rev_to_cpuid(mc->hdr.patch_id).full == bsp_cpuid_1_eax;
+	else
+		return eq_id == mc->hdr.processor_rev_id;
+}
+
 /*
  * This scans the ucode blob for the proper container as we can have multiple
  * containers glued together. Returns the equivalence ID from the equivalence
@@ -336,7 +406,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 	 * doesn't contain a patch for the CPU, scan through the whole container
 	 * so that it can be skipped in case there are other containers appended.
 	 */
-	eq_id = find_equiv_id(&table, desc->cpuid_1_eax);
+	eq_id = find_equiv_id(&table, bsp_cpuid_1_eax);
 
 	buf  += hdr[2] + CONTAINER_HDR_SZ;
 	size -= hdr[2] + CONTAINER_HDR_SZ;
@@ -350,7 +420,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		u32 patch_size;
 		int ret;
 
-		ret = verify_patch(x86_family(desc->cpuid_1_eax), buf, size, &patch_size);
+		ret = verify_patch(buf, size, &patch_size);
 		if (ret < 0) {
 			/*
 			 * Patch verification failed, skip to the next container, if
@@ -363,7 +433,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		}
 
 		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
-		if (eq_id == mc->hdr.processor_rev_id) {
+		if (mc_patch_matches(mc, eq_id)) {
 			desc->psize = patch_size;
 			desc->mc = mc;
 		}
@@ -421,6 +491,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 
 	/* verify patch application was successful */
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
 	if (rev != mc->hdr.patch_id)
 		return -1;
 
@@ -438,14 +509,12 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
  *
  * Returns true if container found (sets @desc), false otherwise.
  */
-static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, size_t size)
+static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
 {
 	struct cont_desc desc = { 0 };
 	struct microcode_amd *mc;
 	bool ret = false;
 
-	desc.cpuid_1_eax = cpuid_1_eax;
-
 	scan_containers(ucode, size, &desc);
 
 	mc = desc.mc;
@@ -463,9 +532,10 @@ static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, siz
 	return !__apply_microcode_amd(mc);
 }
 
-static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
+static bool get_builtin_microcode(struct cpio_data *cp)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
+	u8 family = x86_family(bsp_cpuid_1_eax);
 	struct firmware fw;
 
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -484,11 +554,11 @@ static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
 	return false;
 }
 
-static void __init find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data *ret)
+static void __init find_blobs_in_containers(struct cpio_data *ret)
 {
 	struct cpio_data cp;
 
-	if (!get_builtin_microcode(&cp, x86_family(cpuid_1_eax)))
+	if (!get_builtin_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
 	*ret = cp;
@@ -499,16 +569,18 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 	struct cpio_data cp = { };
 	u32 dummy;
 
+	bsp_cpuid_1_eax = cpuid_1_eax;
+
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->old_rev, dummy);
 
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
 
-	find_blobs_in_containers(cpuid_1_eax, &cp);
+	find_blobs_in_containers(&cp);
 	if (!(cp.data && cp.size))
 		return;
 
-	if (early_apply_microcode(cpuid_1_eax, ed->old_rev, cp.data, cp.size))
+	if (early_apply_microcode(ed->old_rev, cp.data, cp.size))
 		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 
@@ -525,12 +597,10 @@ static int __init save_microcode_in_initrd(void)
 	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
 		return 0;
 
-	find_blobs_in_containers(cpuid_1_eax, &cp);
+	find_blobs_in_containers(&cp);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
 
-	desc.cpuid_1_eax = cpuid_1_eax;
-
 	scan_containers(cp.data, cp.size, &desc);
 	if (!desc.mc)
 		return -EINVAL;
@@ -543,26 +613,65 @@ static int __init save_microcode_in_initrd(void)
 }
 early_initcall(save_microcode_in_initrd);
 
+static inline bool patch_cpus_equivalent(struct ucode_patch *p, struct ucode_patch *n)
+{
+	/* Zen and newer hardcode the f/m/s in the patch ID */
+        if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
+		union cpuid_1_eax p_cid = ucode_rev_to_cpuid(p->patch_id);
+		union cpuid_1_eax n_cid = ucode_rev_to_cpuid(n->patch_id);
+
+		/* Zap stepping */
+		p_cid.stepping = 0;
+		n_cid.stepping = 0;
+
+		return p_cid.full == n_cid.full;
+	} else {
+		return p->equiv_cpu == n->equiv_cpu;
+	}
+}
+
 /*
  * a small, trivial cache of per-family ucode patches
  */
-static struct ucode_patch *cache_find_patch(u16 equiv_cpu)
+static struct ucode_patch *cache_find_patch(struct ucode_cpu_info *uci, u16 equiv_cpu)
 {
 	struct ucode_patch *p;
+	struct ucode_patch n;
+
+	n.equiv_cpu = equiv_cpu;
+	n.patch_id  = uci->cpu_sig.rev;
+
+	WARN_ON_ONCE(!n.patch_id);
 
 	list_for_each_entry(p, &microcode_cache, plist)
-		if (p->equiv_cpu == equiv_cpu)
+		if (patch_cpus_equivalent(p, &n))
 			return p;
+
 	return NULL;
 }
 
+static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
+{
+	/* Zen and newer hardcode the f/m/s in the patch ID */
+        if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
+		union zen_patch_rev zp, zn;
+
+		zp.ucode_rev = p->patch_id;
+		zn.ucode_rev = n->patch_id;
+
+		return zn.rev > zp.rev;
+	} else {
+		return n->patch_id > p->patch_id;
+	}
+}
+
 static void update_cache(struct ucode_patch *new_patch)
 {
 	struct ucode_patch *p;
 
 	list_for_each_entry(p, &microcode_cache, plist) {
-		if (p->equiv_cpu == new_patch->equiv_cpu) {
-			if (p->patch_id >= new_patch->patch_id) {
+		if (patch_cpus_equivalent(p, new_patch)) {
+			if (!patch_newer(p, new_patch)) {
 				/* we already have the latest patch */
 				kfree(new_patch->data);
 				kfree(new_patch);
@@ -593,13 +702,22 @@ static void free_cache(void)
 static struct ucode_patch *find_patch(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	u32 rev, dummy __always_unused;
 	u16 equiv_id;
 
-	equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
-	if (!equiv_id)
-		return NULL;
+	/* fetch rev if not populated yet: */
+	if (!uci->cpu_sig.rev) {
+		rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+		uci->cpu_sig.rev = rev;
+	}
+
+	if (x86_family(bsp_cpuid_1_eax) < 0x17) {
+		equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
+		if (!equiv_id)
+			return NULL;
+	}
 
-	return cache_find_patch(equiv_id);
+	return cache_find_patch(uci, equiv_id);
 }
 
 void reload_ucode_amd(unsigned int cpu)
@@ -649,7 +767,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
 	enum ucode_state ret;
-	u32 rev, dummy __always_unused;
+	u32 rev;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
 
@@ -659,11 +777,11 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	if (!p)
 		return UCODE_NFOUND;
 
+	rev = uci->cpu_sig.rev;
+
 	mc_amd  = p->data;
 	uci->mc = p->data;
 
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
 	/* need to apply patch? */
 	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
@@ -709,6 +827,10 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	hdr = (const u32 *)buf;
 	equiv_tbl_len = hdr[2];
 
+	/* Zen and newer do not need an equivalence table. */
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		goto out;
+
 	equiv_table.entry = vmalloc(equiv_tbl_len);
 	if (!equiv_table.entry) {
 		pr_err("failed to allocate equivalent CPU table\n");
@@ -718,12 +840,16 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	memcpy(equiv_table.entry, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
 	equiv_table.num_entries = equiv_tbl_len / sizeof(struct equiv_cpu_entry);
 
+out:
 	/* add header length */
 	return equiv_tbl_len + CONTAINER_HDR_SZ;
 }
 
 static void free_equiv_cpu_table(void)
 {
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		return;
+
 	vfree(equiv_table.entry);
 	memset(&equiv_table, 0, sizeof(equiv_table));
 }
@@ -749,7 +875,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 	u16 proc_id;
 	int ret;
 
-	ret = verify_patch(family, fw, leftover, patch_size);
+	ret = verify_patch(fw, leftover, patch_size);
 	if (ret)
 		return ret;
 
@@ -774,7 +900,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 	patch->patch_id  = mc_hdr->patch_id;
 	patch->equiv_cpu = proc_id;
 
-	pr_debug("%s: Added patch_id: 0x%08x, proc_id: 0x%04x\n",
+	pr_debug("%s: Adding patch_id: 0x%08x, proc_id: 0x%04x\n",
 		 __func__, patch->patch_id, proc_id);
 
 	/* ... and add to cache. */

