Return-Path: <linux-tip-commits+bounces-5580-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5AABA00B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA78503605
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECDF1C1F0D;
	Fri, 16 May 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoyDFv/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424D1BCA07;
	Fri, 16 May 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409917; cv=none; b=OD1Tx0Ke1exQmSOtAeuV4lbbyCJFkjieo9NDMw6pl75liytdMBprQnp4aRlnvhfLBl3wA48uip9HJhU3TAVG3Yxg1qA9fdiYH6YxVW03zuCYd0JleUiS58snFoMm3IaY1JGGatrO24aqUTfDxROdja9ngI/r0sgbPGooKq8WPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409917; c=relaxed/simple;
	bh=p/CJELP+LYI04oeiLrNDf1hN9tbg6iLdso7k5jp9WAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke/n88Es03v+YLIImxK5N+y/oxnM5w3ZPRyX6uG74DHbyEloocBmt2bM6KOhjdAqvBX6HX9I6b0CnNj9Gd24ajjjs5uv9ZeBzp/zpggcAnxJwKfh2gx0huilIywShGNm6QMmEE1zapFh4KS2GaRxSQpGsCuCmz3x9LXcVwPaT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoyDFv/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6742FC4CEE4;
	Fri, 16 May 2025 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747409917;
	bh=p/CJELP+LYI04oeiLrNDf1hN9tbg6iLdso7k5jp9WAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoyDFv/F0wQNV4gdc0CpieobyL+iC5qY4+BbOyScBKPO0bV9CgmaWGThPX0tAlTo7
	 BeFT2e7UnFas36YJjPUxsOT5aToPCQU24HvOwphxe1y+UEjUHoUXKDfQWUvPRFOHga
	 tKhgKfBHOByXIowU3dqwwu97qu1GDtGlXQM0WxqRyoIbYIvfhIPwlFMz8d3cdC+A8c
	 l/PY5532VN3tDnOpkIqU0xm/VPAUlavpeg3uMKHcA1LmgFIjn4qcbSxFXMYy5Qxr0K
	 CQbvzuJAWUCwW0XIbFzF63hnAZaxzXCRUqZm/j4sw1Pbc1ihVMr0nLRaCSbUneu6tp
	 d03taouRq8H3A==
Date: Fri, 16 May 2025 17:38:31 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: [PATCH] x86/bugs: Apply misc stylistic touchups
Message-ID: <aCdb9wY6YfIXMhT6@gmail.com>
References: <174740680468.406.372152086131806707.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174740680468.406.372152086131806707.tip-bot2@tip-bot2>


* tip-bot2 for Borislav Petkov (AMD) <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/core branch of tip:
> 
> Commit-ID:     ff8f7a889abd9741abde6e83d33a3a7d9d6e7d83
> Gitweb:        https://git.kernel.org/tip/ff8f7a889abd9741abde6e83d33a3a7d9d6e7d83
> Author:        Borislav Petkov (AMD) <bp@alien8.de>
> AuthorDate:    Fri, 16 May 2025 16:31:38 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Fri, 16 May 2025 16:31:38 +02:00
> 
> x86/bugs: Fix indentation due to ITS merge
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/kernel/cpu/bugs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index dd8b50b..d1a03ff 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2975,10 +2975,10 @@ static void __init srso_apply_mitigation(void)
>  
>  		if (boot_cpu_data.x86 == 0x19) {
>  			setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
> -				set_return_thunk(srso_alias_return_thunk);
> +			set_return_thunk(srso_alias_return_thunk);
>  		} else {
>  			setup_force_cpu_cap(X86_FEATURE_SRSO);
> -				set_return_thunk(srso_return_thunk);
> +			set_return_thunk(srso_return_thunk);
>  		}
>  		break;
>  	case SRSO_MITIGATION_IBPB:

This reminded me of this bugs.c housekeeping patch I have stashed:

===================================>
From: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/bugs: Apply misc stylistic touchups

 - s/its/it's

 - Use the pr_fmt 'RETBleed' string consistently in other messages as well

 - Use the pr_fmt 'Spectre V2' string consistently in other messages as well

 - Use 'user space' consistently. (vs. 'userspace')

 - Capitalize 'SWAPGS' consistently.

 - Capitalize 'L1D' consistently.

 - Spell '44 bits' consistently.

 - Consistently use empty lines before final 'return' statements where justified.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 51 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -172,7 +172,7 @@ DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
 
 /*
- * Controls whether l1d flush based mitigations are enabled,
+ * Controls whether L1D flush based mitigations are enabled,
  * based on hw features and admin setting via boot parameter
  * defaults to false
  */
@@ -286,7 +286,7 @@ x86_virt_spec_ctrl(u64 guest_virt_spec_ctrl, bool setguest)
 
 	/*
 	 * If the host has SSBD mitigation enabled, force it in the host's
-	 * virtual MSR value. If its not permanently enabled, evaluate
+	 * virtual MSR value. If it's not permanently enabled, evaluate
 	 * current's TIF_SSBD thread flag.
 	 */
 	if (static_cpu_has(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE))
@@ -1028,13 +1028,13 @@ static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
 		SPECTRE_V1_MITIGATION_AUTO : SPECTRE_V1_MITIGATION_NONE;
 
 static const char * const spectre_v1_strings[] = {
-	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",
-	[SPECTRE_V1_MITIGATION_AUTO] = "Mitigation: usercopy/swapgs barriers and __user pointer sanitization",
+	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no SWAPGS barriers",
+	[SPECTRE_V1_MITIGATION_AUTO] = "Mitigation: usercopy/SWAPGS barriers and __user pointer sanitization",
 };
 
 /*
  * Does SMAP provide full mitigation against speculative kernel access to
- * userspace?
+ * user space?
  */
 static bool smap_works_speculatively(void)
 {
@@ -1067,7 +1067,7 @@ static void __init spectre_v1_apply_mitigation(void)
 	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {
 		/*
 		 * With Spectre v1, a user can speculatively control either
-		 * path of a conditional swapgs with a user-controlled GS
+		 * path of a conditional SWAPGS with a user-controlled GS
 		 * value.  The mitigation is to add lfences to both code paths.
 		 *
 		 * If FSGSBASE is enabled, the user can put a kernel address in
@@ -1085,16 +1085,16 @@ static void __init spectre_v1_apply_mitigation(void)
 			 * is serializing.
 			 *
 			 * If neither is there, mitigate with an LFENCE to
-			 * stop speculation through swapgs.
+			 * stop speculation through SWAPGS.
 			 */
 			if (boot_cpu_has_bug(X86_BUG_SWAPGS) &&
 			    !boot_cpu_has(X86_FEATURE_PTI))
 				setup_force_cpu_cap(X86_FEATURE_FENCE_SWAPGS_USER);
 
 			/*
-			 * Enable lfences in the kernel entry (non-swapgs)
+			 * Enable lfences in the kernel entry (non-SWAPGS)
 			 * paths, to prevent user entry from speculatively
-			 * skipping swapgs.
+			 * skipping SWAPGS.
 			 */
 			setup_force_cpu_cap(X86_FEATURE_FENCE_SWAPGS_KERNEL);
 		}
@@ -1177,7 +1177,7 @@ static int __init retbleed_parse_cmdline(char *str)
 early_param("retbleed", retbleed_parse_cmdline);
 
 #define RETBLEED_UNTRAIN_MSG "WARNING: BTB untrained return thunk mitigation is only effective on AMD/Hygon!\n"
-#define RETBLEED_INTEL_MSG "WARNING: Spectre v2 mitigation leaves CPU vulnerable to RETBleed attacks, data leaks possible!\n"
+#define RETBLEED_INTEL_MSG "WARNING: Spectre V2 mitigation leaves CPU vulnerable to RETBleed attacks, data leaks possible!\n"
 
 static void __init retbleed_select_mitigation(void)
 {
@@ -1415,7 +1415,7 @@ static void __init its_select_mitigation(void)
 		goto out;
 	}
 	if (spectre_v2_enabled == SPECTRE_V2_NONE) {
-		pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
+		pr_err("WARNING: Spectre V2 mitigation is off, disabling ITS\n");
 		its_mitigation = ITS_MITIGATION_OFF;
 		goto out;
 	}
@@ -1466,7 +1466,7 @@ static void __init its_select_mitigation(void)
 		set_return_thunk(call_depth_return_thunk);
 		if (retbleed_mitigation == RETBLEED_MITIGATION_NONE) {
 			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
-			pr_info("Retbleed mitigation updated to stuffing\n");
+			pr_info("RETBleed mitigation updated to stuffing\n");
 		}
 		break;
 	}
@@ -1490,8 +1490,9 @@ bool retpoline_module_ok(bool has_retpoline)
 	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
 		return true;
 
-	pr_err("System may be vulnerable to spectre v2\n");
+	pr_err("System may be vulnerable to Spectre V2\n");
 	spectre_v2_bad_module = true;
+
 	return false;
 }
 
@@ -1504,8 +1505,8 @@ static inline const char *spectre_v2_module_string(void) { return ""; }
 #endif
 
 #define SPECTRE_V2_LFENCE_MSG "WARNING: LFENCE mitigation is not recommended for this CPU, data leaks possible!\n"
-#define SPECTRE_V2_EIBRS_EBPF_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!\n"
-#define SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS+LFENCE mitigation and SMT, data leaks possible via Spectre v2 BHB attacks!\n"
+#define SPECTRE_V2_EIBRS_EBPF_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre V2 BHB attacks!\n"
+#define SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS+LFENCE mitigation and SMT, data leaks possible via Spectre V2 BHB attacks!\n"
 #define SPECTRE_V2_IBRS_PERF_MSG "WARNING: IBRS mitigation selected on Enhanced IBRS CPU, this may cause unnecessary performance loss\n"
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -1537,7 +1538,7 @@ static inline bool match_option(const char *arg, int arglen, const char *opt)
 	return len == arglen && !strncmp(arg, opt, len);
 }
 
-/* The kernel command line selection for spectre v2 */
+/* The kernel command line selection for Spectre V2 */
 enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_NONE,
 	SPECTRE_V2_CMD_AUTO,
@@ -1697,7 +1698,7 @@ static void __init spectre_v2_user_update_mitigation(void)
 	 * injection in user-mode as the IBRS bit remains always set which
 	 * implicitly enables cross-thread protections.  However, in legacy IBRS
 	 * mode, the IBRS bit is set only on kernel entry and cleared on return
-	 * to userspace.  AMD Automatic IBRS also does not protect userspace.
+	 * to user space.  AMD Automatic IBRS also does not protect user space.
 	 * These modes therefore disable the implicit cross-thread protection,
 	 * so allow for STIBP to be selected in those cases.
 	 */
@@ -1714,7 +1715,7 @@ static void __init spectre_v2_user_update_mitigation(void)
 	     retbleed_mitigation == RETBLEED_MITIGATION_IBPB)) {
 		if (spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT &&
 		    spectre_v2_user_stibp != SPECTRE_V2_USER_STRICT_PREFERRED)
-			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
+			pr_info("Selecting STIBP always-on mode to complement RETBleed mitigation\n");
 		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT_PREFERRED;
 	}
 	pr_info("%s\n", spectre_v2_user_strings[spectre_v2_user_stibp]);
@@ -1923,7 +1924,7 @@ static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation m
 	case SPECTRE_V2_EIBRS_LFENCE:
 	case SPECTRE_V2_EIBRS_RETPOLINE:
 		if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
-			pr_info("Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
+			pr_info("Spectre V2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
 			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 		}
 		break;
@@ -1931,13 +1932,13 @@ static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation m
 	case SPECTRE_V2_RETPOLINE:
 	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
-		pr_info("Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT\n");
+		pr_info("Spectre V2 / SpectreRSB: Filling RSB on context switch and VMEXIT\n");
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		break;
 
 	default:
-		pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation\n");
+		pr_warn_once("Unknown Spectre V2 mode, disabling RSB mitigation\n");
 		dump_stack();
 		break;
 	}
@@ -1945,7 +1946,7 @@ static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation m
 
 /*
  * Set BHI_DIS_S to prevent indirect branches in kernel to be influenced by
- * branch history in userspace. Not needed if BHI_NO is set.
+ * branch history in user space. Not needed if BHI_NO is set.
  */
 static bool __init spec_ctrl_bhi_dis(void)
 {
@@ -2696,7 +2697,7 @@ enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
 
 /*
- * These CPUs all support 44bits physical address space internally in the
+ * These CPUs all support 44 bits physical address space internally in the
  * cache but CPUID can report a smaller number of physical address bits.
  *
  * The L1TF mitigation uses the top most address bit for the inversion of
@@ -2705,9 +2706,9 @@ EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
  * which report 36bits physical address bits and have 32G RAM installed,
  * then the mitigation range check in l1tf_select_mitigation() triggers.
  * This is a false positive because the mitigation is still possible due to
- * the fact that the cache uses 44bit internally. Use the cache bits
+ * the fact that the cache uses 44 bits internally. Use the cache bits
  * instead of the reported physical bits and adjust them on the affected
- * machines to 44bit if the reported bits are less than 44.
+ * machines to 44 bits if the reported bits are less than 44.
  */
 static void override_cache_bits(struct cpuinfo_x86 *c)
 {

