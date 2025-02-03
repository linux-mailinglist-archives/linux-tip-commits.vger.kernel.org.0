Return-Path: <linux-tip-commits+bounces-3319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5AA25A1E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798103A9A4C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FB205E1B;
	Mon,  3 Feb 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UyAAYLni";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOziikFO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF08205AAB;
	Mon,  3 Feb 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587008; cv=none; b=WM0EWo2T/em7Vkj1FP57I7DjpMXHUZFhnTvcLw2rNOr8NTs7Zm7yBQii2WogG9qqZZ69iMefm2tEBIPu45LjXz29SE6DTSOyOqYD965jDYT59pc49xznNjSlqKumz8I6DLErhdOPQHrY0DIrq5ZFV2VsHr7IEilkfTrwx5z2RgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587008; c=relaxed/simple;
	bh=Ha9N3bw1ZLDNseO03L7kyWnm7kKUSOvGjyrAhH/nPMI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m1ge/F0PM+fE+vUolAtCZQT3tJMHOYlriRI3vI7cvBBW/Cb5UEzOIsDY0PDp7q9RMGMi2I145H3E8HXahwfZZrCqZgKogZWpFafUYgZcci55TROrbPmyr6YoAedoO3htC6hK/aFc/KM4WdiuOeSFITAPJd/UB/A+INQ9V+HpBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UyAAYLni; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tOziikFO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:50:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738587005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MMwPzSXVceMZ8FuDso8mODOIiHgcb767ZP674FPSKU=;
	b=UyAAYLniDHXGRApsRvLW1kVUetVUb6fV+IpUqBdzJvpNsKZAWZCqUH8lwYGLswPAkcojU2
	vctpFrUzpS6zw70tM629dI4UhnXTUFa2dLWGlB1cMBx9oWDE++t7yAyI1qZ61LV/uIuKUr
	0yaFkDZVEBuPGuNA7ONPuo+gRi0V5i8IaEFGgUZLyxJR8acSYO10eTZOI8enMM04o4II5G
	tbzrRMz5rBAMnkL5bMct4f9k022QEAQDkn0Oj/em5TOGU+A7ATC39mut7PGAPSgQkHkryC
	/b2u4+DhWAjni0HnaZdlp3BeSQXxZMZauW2huhfzR+5iNguujW5Zhg2xI/vvlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738587005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MMwPzSXVceMZ8FuDso8mODOIiHgcb767ZP674FPSKU=;
	b=tOziikFO4hYKl2yzpWJsRPj+iOoqN+JfMMWZJKzHThjqpQQmwm6HYmTDgs2U9KfuqI/oFD
	uAlEduarRcOs8VAg==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] module: switch to execmem API for remapping as RW and
 restoring ROX
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250126074733.1384926-7-rppt@kernel.org>
References: <20250126074733.1384926-7-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858700441.10177.9463798553960780539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c287c072332905b7d878a8aade86cfef6b396343
Gitweb:        https://git.kernel.org/tip/c287c072332905b7d878a8aade86cfef6b396343
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Sun, 26 Jan 2025 09:47:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:02 +01:00

module: switch to execmem API for remapping as RW and restoring ROX

Instead of using writable copy for module text sections, temporarily remap
the memory allocated from execmem's ROX cache as writable and restore its
ROX permissions after the module is formed.

This will allow removing nasty games with writable copy in alternatives
patching on x86.

Signed-off-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250126074733.1384926-7-rppt@kernel.org
---
 include/linux/module.h       |  8 +----
 include/linux/moduleloader.h |  4 +--
 kernel/module/main.c         | 78 +++++++++--------------------------
 kernel/module/strict_rwx.c   |  9 ++--
 4 files changed, 27 insertions(+), 72 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 23792d5..ddf27ed 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -367,7 +367,6 @@ enum mod_mem_type {
 
 struct module_memory {
 	void *base;
-	void *rw_copy;
 	bool is_rox;
 	unsigned int size;
 
@@ -769,14 +768,9 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void set_module_sig_enforced(void);
 
-void *__module_writable_address(struct module *mod, void *loc);
-
 static inline void *module_writable_address(struct module *mod, void *loc)
 {
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_EXECMEM_ROX) || !mod ||
-	    mod->state != MODULE_STATE_UNFORMED)
-		return loc;
-	return __module_writable_address(mod, loc);
+	return loc;
 }
 
 #else /* !CONFIG_MODULES... */
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 1f5507b..e395461 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -108,10 +108,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *mod);
 
-int module_post_finalize(const Elf_Ehdr *hdr,
-			 const Elf_Shdr *sechdrs,
-			 struct module *mod);
-
 #ifdef CONFIG_MODULES
 void flush_module_init_free_work(void);
 #else
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad2..5c127be 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1221,18 +1221,6 @@ void __weak module_arch_freeing_init(struct module *mod)
 {
 }
 
-void *__module_writable_address(struct module *mod, void *loc)
-{
-	for_class_mod_mem_type(type, text) {
-		struct module_memory *mem = &mod->mem[type];
-
-		if (loc >= mem->base && loc < mem->base + mem->size)
-			return loc + (mem->rw_copy - mem->base);
-	}
-
-	return loc;
-}
-
 static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 {
 	unsigned int size = PAGE_ALIGN(mod->mem[type].size);
@@ -1250,21 +1238,15 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	if (!ptr)
 		return -ENOMEM;
 
-	mod->mem[type].base = ptr;
-
 	if (execmem_is_rox(execmem_type)) {
-		ptr = vzalloc(size);
+		int err = execmem_make_temp_rw(ptr, size);
 
-		if (!ptr) {
-			execmem_free(mod->mem[type].base);
+		if (err) {
+			execmem_free(ptr);
 			return -ENOMEM;
 		}
 
-		mod->mem[type].rw_copy = ptr;
 		mod->mem[type].is_rox = true;
-	} else {
-		mod->mem[type].rw_copy = mod->mem[type].base;
-		memset(mod->mem[type].base, 0, size);
 	}
 
 	/*
@@ -1280,16 +1262,26 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	 */
 	kmemleak_not_leak(ptr);
 
+	memset(ptr, 0, size);
+	mod->mem[type].base = ptr;
+
 	return 0;
 }
 
+static void module_memory_restore_rox(struct module *mod)
+{
+	for_class_mod_mem_type(type, text) {
+		struct module_memory *mem = &mod->mem[type];
+
+		if (mem->is_rox)
+			execmem_restore_rox(mem->base, mem->size);
+	}
+}
+
 static void module_memory_free(struct module *mod, enum mod_mem_type type)
 {
 	struct module_memory *mem = &mod->mem[type];
 
-	if (mem->is_rox)
-		vfree(mem->rw_copy);
-
 	execmem_free(mem->base);
 }
 
@@ -2642,7 +2634,6 @@ static int move_module(struct module *mod, struct load_info *info)
 	for_each_mod_mem_type(type) {
 		if (!mod->mem[type].size) {
 			mod->mem[type].base = NULL;
-			mod->mem[type].rw_copy = NULL;
 			continue;
 		}
 
@@ -2659,7 +2650,6 @@ static int move_module(struct module *mod, struct load_info *info)
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
 		const char *sname;
-		unsigned long addr;
 
 		if (!(shdr->sh_flags & SHF_ALLOC))
 			continue;
@@ -2680,14 +2670,12 @@ static int move_module(struct module *mod, struct load_info *info)
 				ret = PTR_ERR(dest);
 				goto out_err;
 			}
-			addr = (unsigned long)dest;
 			codetag_section_found = true;
 		} else {
 			enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
 			unsigned long offset = shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK;
 
-			addr = (unsigned long)mod->mem[type].base + offset;
-			dest = mod->mem[type].rw_copy + offset;
+			dest = mod->mem[type].base + offset;
 		}
 
 		if (shdr->sh_type != SHT_NOBITS) {
@@ -2710,13 +2698,14 @@ static int move_module(struct module *mod, struct load_info *info)
 		 * users of info can keep taking advantage and using the newly
 		 * minted official memory area.
 		 */
-		shdr->sh_addr = addr;
+		shdr->sh_addr = (unsigned long)dest;
 		pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
 			 (long)shdr->sh_size, info->secstrings + shdr->sh_name);
 	}
 
 	return 0;
 out_err:
+	module_memory_restore_rox(mod);
 	for (t--; t >= 0; t--)
 		module_memory_free(mod, t);
 	if (codetag_section_found)
@@ -2863,17 +2852,8 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
 	return 0;
 }
 
-int __weak module_post_finalize(const Elf_Ehdr *hdr,
-				const Elf_Shdr *sechdrs,
-				struct module *me)
-{
-	return 0;
-}
-
 static int post_relocation(struct module *mod, const struct load_info *info)
 {
-	int ret;
-
 	/* Sort exception table now relocations are done. */
 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
 
@@ -2885,24 +2865,7 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	add_kallsyms(mod, info);
 
 	/* Arch-specific module finalizing. */
-	ret = module_finalize(info->hdr, info->sechdrs, mod);
-	if (ret)
-		return ret;
-
-	for_each_mod_mem_type(type) {
-		struct module_memory *mem = &mod->mem[type];
-
-		if (mem->is_rox) {
-			if (!execmem_update_copy(mem->base, mem->rw_copy,
-						 mem->size))
-				return -ENOMEM;
-
-			vfree(mem->rw_copy);
-			mem->rw_copy = NULL;
-		}
-	}
-
-	return module_post_finalize(info->hdr, info->sechdrs, mod);
+	return module_finalize(info->hdr, info->sechdrs, mod);
 }
 
 /* Call module constructors. */
@@ -3499,6 +3462,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 				       mod->mem[type].size);
 	}
 
+	module_memory_restore_rox(mod);
 	module_deallocate(mod, info);
  free_copy:
 	/*
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 74834ba..03f4142 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/execmem.h>
 #include "internal.h"
 
 static int module_set_memory(const struct module *mod, enum mod_mem_type type,
@@ -32,12 +33,12 @@ static int module_set_memory(const struct module *mod, enum mod_mem_type type,
 int module_enable_text_rox(const struct module *mod)
 {
 	for_class_mod_mem_type(type, text) {
+		const struct module_memory *mem = &mod->mem[type];
 		int ret;
 
-		if (mod->mem[type].is_rox)
-			continue;
-
-		if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		if (mem->is_rox)
+			ret = execmem_restore_rox(mem->base, mem->size);
+		else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 			ret = module_set_memory(mod, type, set_memory_rox);
 		else
 			ret = module_set_memory(mod, type, set_memory_x);

