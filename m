Return-Path: <linux-tip-commits+bounces-6485-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE4B454BF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B68B563C7B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5352828313D;
	Fri,  5 Sep 2025 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YXEElJRv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ud+YxfKf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DD2D7818;
	Fri,  5 Sep 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068216; cv=none; b=gliVY7JpF7EyVQytn4wW2ecRenutXP8/kyKUL29oYki38rgbSarjvPyHiZ6ma1ILVI9YDtWiQnGCUEIQGxyoISxcW/esBhtIQ6fUF8jhAELIDjAx9VQTOkL2XuEaitTWBV4dQds+Avf4X9v1BYjP4T4nk7iKMKZeBpuaP+UEcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068216; c=relaxed/simple;
	bh=AvdKjfY1nmu2A9RRkmnfiEoEICFUrvdgivdqcobWvUk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u7plPHxN9y70EUznc/klmTFvU9UsIniMFUnQZIWYnjJmhfS34AfZqLa+BVrxJgXBiePhKOQJiDSeQDQ/3w/S4fn2NtfwjQNhEmyMBc+17cJ7IYZnDP8Yrnk+08CKQvyq3i8Vvyf+djZaOkZ7G5m/3tPcUX/FlKpjMKuqW1+UAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YXEElJRv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ud+YxfKf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 10:30:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757068212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2c731s1kfDUHO/N/bvoRyPGz1HoP9Qws8AgQYbl/DqE=;
	b=YXEElJRvMKG05kyoEeUgKCcFb0w0EgcewChuYglJCI40YniczNZdg8gTn/Go45hUG9MTx5
	DXC7Qr8E4hfTsP7TXB6dleglBMgYTmqVLOXpnLosypOD5JuzCXNkjZbNQ3AlKxUgwfbj8Q
	Ysr+uK0izo57bcU9q0SOACcg+3ZOdRGvL0JpuGe2joj4wkEXQmZfdk7BOamUYtU+04fLwF
	OBWswrRdaQkIVBJo9lPsFY7ny4oQ0bgnscg8VigFKxzvKUW2hBFKhNChMex0+pwsIIbrdv
	eyK+9sUP8oSmIaG5DqnNc/CbowRtCn3BZbpXodYYCawPSsjCu+eKjA+r8DaEsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757068212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2c731s1kfDUHO/N/bvoRyPGz1HoP9Qws8AgQYbl/DqE=;
	b=Ud+YxfKfsgdNiyUnTw89R95KPTPcYXevG4ELbvspU5VFerdk/3K/Mf1ICwaNbgEy83fFTb
	HYIieybmz692n1AA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add microcode loader debugging
 functionality
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820135043.19048-3-bp@kernel.org>
References: <20250820135043.19048-3-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175706820782.1920.7999909861831981397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     43181a47263dd9f2bee0afd688a841b09f9b7d12
Gitweb:        https://git.kernel.org/tip/43181a47263dd9f2bee0afd688a841b09f9=
b7d12
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 20 Aug 2025 15:50:43 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Sep 2025 16:15:19 +02:00

x86/microcode: Add microcode loader debugging functionality

Instead of adding ad-hoc debugging glue to the microcode loader each
time I need it, add debugging functionality which is not built by
default.

Simulate all patch handling the loader does except the actual loading of
the microcode patch into the hardware.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250820135043.19048-3-bp@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +-
 arch/x86/Kconfig                                | 12 +++-
 arch/x86/kernel/cpu/microcode/amd.c             | 73 +++++++++++-----
 arch/x86/kernel/cpu/microcode/core.c            | 21 ++++-
 arch/x86/kernel/cpu/microcode/internal.h        |  9 ++-
 5 files changed, 96 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 9e3bbce..2c142e5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3770,6 +3770,10 @@
 	microcode=3D      [X86] Control the behavior of the microcode loader.
 	                Available options, comma separated:
=20
+			base_rev=3DX - with <X> with format: <u32>
+			Set the base microcode revision of each thread when in
+			debug mode.
+
 			dis_ucode_ldr: disable the microcode loader
=20
 			force_minrev:
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aa250d9..77f72f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1360,6 +1360,18 @@ config MICROCODE_LATE_FORCE_MINREV
=20
 	  If unsure say Y.
=20
+config MICROCODE_DBG
+	bool "Enable microcode loader debugging"
+	default n
+	depends on MICROCODE
+	help
+	  Enable code which allows for debugging the microcode loader in
+	  a guest. Meaning the patch loading is simulated but everything else
+	  related to patch parsing and handling is done as on baremetal with
+	  the purpose of debugging solely the software side of things.
+
+	  You almost certainly want to say n here.
+
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
 	help
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 514f633..cdce885 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -269,15 +269,6 @@ static bool verify_sha256_digest(u32 patch_id, u32 cur_r=
ev, const u8 *data, unsi
 	return true;
 }
=20
-static u32 get_patch_level(void)
-{
-	u32 rev, dummy __always_unused;
-
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	return rev;
-}
-
 static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
 {
 	union zen_patch_rev p;
@@ -295,6 +286,30 @@ static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int=
 val)
 	return c;
 }
=20
+static u32 get_patch_level(void)
+{
+	u32 rev, dummy __always_unused;
+
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
+		int cpu =3D smp_processor_id();
+
+		if (!microcode_rev[cpu]) {
+			if (!base_rev)
+				base_rev =3D cpuid_to_ucode_rev(bsp_cpuid_1_eax);
+
+			microcode_rev[cpu] =3D base_rev;
+
+			ucode_dbg("CPU%d, base_rev: 0x%x\n", cpu, base_rev);
+		}
+
+		return microcode_rev[cpu];
+	}
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
+	return rev;
+}
+
 static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 {
 	unsigned int i;
@@ -324,13 +339,13 @@ static bool verify_container(const u8 *buf, size_t buf_=
size)
 	u32 cont_magic;
=20
 	if (buf_size <=3D CONTAINER_HDR_SZ) {
-		pr_debug("Truncated microcode container header.\n");
+		ucode_dbg("Truncated microcode container header.\n");
 		return false;
 	}
=20
 	cont_magic =3D *(const u32 *)buf;
 	if (cont_magic !=3D UCODE_MAGIC) {
-		pr_debug("Invalid magic value (0x%08x).\n", cont_magic);
+		ucode_dbg("Invalid magic value (0x%08x).\n", cont_magic);
 		return false;
 	}
=20
@@ -355,8 +370,8 @@ static bool verify_equivalence_table(const u8 *buf, size_=
t buf_size)
=20
 	cont_type =3D hdr[1];
 	if (cont_type !=3D UCODE_EQUIV_CPU_TABLE_TYPE) {
-		pr_debug("Wrong microcode container equivalence table type: %u.\n",
-			 cont_type);
+		ucode_dbg("Wrong microcode container equivalence table type: %u.\n",
+			  cont_type);
 		return false;
 	}
=20
@@ -365,7 +380,7 @@ static bool verify_equivalence_table(const u8 *buf, size_=
t buf_size)
 	equiv_tbl_len =3D hdr[2];
 	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
 	    buf_size < equiv_tbl_len) {
-		pr_debug("Truncated equivalence table.\n");
+		ucode_dbg("Truncated equivalence table.\n");
 		return false;
 	}
=20
@@ -385,7 +400,7 @@ static bool __verify_patch_section(const u8 *buf, size_t =
buf_size, u32 *sh_psize
 	const u32 *hdr;
=20
 	if (buf_size < SECTION_HDR_SIZE) {
-		pr_debug("Truncated patch section.\n");
+		ucode_dbg("Truncated patch section.\n");
 		return false;
 	}
=20
@@ -394,13 +409,13 @@ static bool __verify_patch_section(const u8 *buf, size_=
t buf_size, u32 *sh_psize
 	p_size =3D hdr[1];
=20
 	if (p_type !=3D UCODE_UCODE_TYPE) {
-		pr_debug("Invalid type field (0x%x) in container file section header.\n",
-			 p_type);
+		ucode_dbg("Invalid type field (0x%x) in container file section header.\n",
+			  p_type);
 		return false;
 	}
=20
 	if (p_size < sizeof(struct microcode_header_amd)) {
-		pr_debug("Patch of size %u too short.\n", p_size);
+		ucode_dbg("Patch of size %u too short.\n", p_size);
 		return false;
 	}
=20
@@ -477,12 +492,12 @@ static int verify_patch(const u8 *buf, size_t buf_size,=
 u32 *patch_size)
 	 * size sh_psize, as the section claims.
 	 */
 	if (buf_size < sh_psize) {
-		pr_debug("Patch of size %u truncated.\n", sh_psize);
+		ucode_dbg("Patch of size %u truncated.\n", sh_psize);
 		return -1;
 	}
=20
 	if (!__verify_patch_size(sh_psize, buf_size)) {
-		pr_debug("Per-family patch size mismatch.\n");
+		ucode_dbg("Per-family patch size mismatch.\n");
 		return -1;
 	}
=20
@@ -496,6 +511,9 @@ static int verify_patch(const u8 *buf, size_t buf_size, u=
32 *patch_size)
=20
 	proc_id	=3D mc_hdr->processor_rev_id;
 	patch_fam =3D 0xf + (proc_id >> 12);
+
+	ucode_dbg("Patch-ID 0x%08x: family: 0x%x\n", mc_hdr->patch_id, patch_fam);
+
 	if (patch_fam !=3D family)
 		return 1;
=20
@@ -566,9 +584,14 @@ static size_t parse_container(u8 *ucode, size_t size, st=
ruct cont_desc *desc)
 		}
=20
 		mc =3D (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
+
+		ucode_dbg("patch_id: 0x%x\n", mc->hdr.patch_id);
+
 		if (mc_patch_matches(mc, eq_id)) {
 			desc->psize =3D patch_size;
 			desc->mc =3D mc;
+
+			ucode_dbg(" match: size: %d\n", patch_size);
 		}
=20
 skip:
@@ -639,8 +662,14 @@ static bool __apply_microcode_amd(struct microcode_amd *=
mc, u32 *cur_rev,
 			invlpg(p_addr_end);
 	}
=20
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG))
+		microcode_rev[smp_processor_id()] =3D mc->hdr.patch_id;
+
 	/* verify patch application was successful */
 	*cur_rev =3D get_patch_level();
+
+	ucode_dbg("updated rev: 0x%x\n", *cur_rev);
+
 	if (*cur_rev !=3D mc->hdr.patch_id)
 		return false;
=20
@@ -1026,7 +1055,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsi=
gned int leftover,
 	patch->patch_id  =3D mc_hdr->patch_id;
 	patch->equiv_cpu =3D proc_id;
=20
-	pr_debug("%s: Adding patch_id: 0x%08x, proc_id: 0x%04x\n",
+	ucode_dbg("%s: Adding patch_id: 0x%08x, proc_id: 0x%04x\n",
 		 __func__, patch->patch_id, proc_id);
=20
 	/* ... and add to cache. */
@@ -1169,7 +1198,7 @@ static enum ucode_state request_microcode_amd(int cpu, =
struct device *device)
 		snprintf(fw_name, sizeof(fw_name), "amd-ucode/microcode_amd_fam%.2xh.bin",=
 c->x86);
=20
 	if (request_firmware_direct(&fw, (const char *)fw_name, device)) {
-		pr_debug("failed to load file %s\n", fw_name);
+		ucode_dbg("failed to load file %s\n", fw_name);
 		goto out;
 	}
=20
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/micro=
code/core.c
index 7d59063..f75c140 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -48,6 +48,16 @@ static bool dis_ucode_ldr;
 bool force_minrev =3D IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
=20
 /*
+ * Those below should be behind CONFIG_MICROCODE_DBG ifdeffery but in
+ * order to not uglify the code with ifdeffery and use IS_ENABLED()
+ * instead, leave them in. When microcode debugging is not enabled,
+ * those are meaningless anyway.
+ */
+/* base microcode revision for debugging */
+u32 base_rev;
+u32 microcode_rev[NR_CPUS] =3D {};
+
+/*
  * Synchronization.
  *
  * All non cpu-hotplug-callback call sites use:
@@ -118,7 +128,8 @@ bool __init microcode_loader_disabled(void)
 	 *    overwritten.
 	 */
 	if (!cpuid_feature() ||
-	    native_cpuid_ecx(1) & BIT(31) ||
+	    ((native_cpuid_ecx(1) & BIT(31)) &&
+	      !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
 	    amd_check_current_patch_level())
 		dis_ucode_ldr =3D true;
=20
@@ -132,6 +143,14 @@ static void early_parse_cmdline(void)
=20
 	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, sizeof(cmd=
_buf)) > 0) {
 		while ((s =3D strsep(&p, ","))) {
+			if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
+				if (strstr(s, "base_rev=3D")) {
+					/* advance to the option arg */
+					strsep(&s, "=3D");
+					if (kstrtouint(s, 16, &base_rev)) { ; }
+				}
+			}
+
 			if (!strcmp("force_minrev", s))
 				force_minrev =3D true;
=20
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/m=
icrocode/internal.h
index 50a9702..ae8dbc2 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -44,6 +44,9 @@ struct early_load_data {
=20
 extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
+extern u32 microcode_rev[NR_CPUS];
+extern u32 base_rev;
+
 struct cpio_data find_microcode_in_initrd(const char *path);
=20
 #define MAX_UCODE_COUNT 128
@@ -122,4 +125,10 @@ static inline void reload_ucode_intel(void) { }
 static inline struct microcode_ops *init_intel_microcode(void) { return NULL=
; }
 #endif  /* !CONFIG_CPU_SUP_INTEL */
=20
+#define ucode_dbg(fmt, ...)					\
+({								\
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG))			\
+		pr_info(fmt, ##__VA_ARGS__);			\
+})
+
 #endif /* _X86_MICROCODE_INTERNAL_H */

