Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E323131B2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhBHMDk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhBHMBV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AA5C061756;
        Mon,  8 Feb 2021 04:00:40 -0800 (PST)
Date:   Mon, 08 Feb 2021 12:00:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXIrh2LsexLNo6PT2sL8pWem9Yr52MxUXTbyGDqyiF0=;
        b=lgO8otnVuiA9Ru94p9xKA9rXIMa9Pv3OC6+TIMcA12B0SJdccgZaGglYk3gfj4NYZs5rN3
        SaN7UHeBQ3a56lL7q4EL9yDuoI6XgQccP6rrKGC9nj5Apw3zOS+XX4CRdd4ouuvFmZgXIW
        bAea7xwgR6+6KPKEg6gjuItMoHwVkgm/EU50kCSf6fUNUpGG8toNHqpQZDG7ESu+yb88Vs
        HgoV9LJIaouO6B+hwFz2osZNTG3wze4jjTamy72DOOIjKupVTX2KNWPNjtdqipJ6dsizjc
        tU3ZYjpVz8xvtz8txyivWHCjpIAYd+4VfmA8mjKReaWt16QKAw3RakzTgFr4RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXIrh2LsexLNo6PT2sL8pWem9Yr52MxUXTbyGDqyiF0=;
        b=BtY+x37oa3oP5UbFiltTY+JppSuI1VLBS1sW94CLA2eePbJHM+TUhp8v+XghyK5TMznYKN
        woKXRZbTyMszQVDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] static_call: Allow module use without exposing
 static_call_key
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127231837.ifddpn7rhwdaepiu@treble>
References: <20210127231837.ifddpn7rhwdaepiu@treble>
MIME-Version: 1.0
Message-ID: <161278563843.23325.169128411901676774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5e444f1cadde5cf3da2bd7a89631519806ac91f7
Gitweb:        https://git.kernel.org/tip/5e444f1cadde5cf3da2bd7a89631519806ac91f7
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 27 Jan 2021 17:18:37 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:59 +01:00

static_call: Allow module use without exposing static_call_key

When exporting static_call_key; with EXPORT_STATIC_CALL*(), the module
can use static_call_update() to change the function called.  This is
not desirable in general.

Not exporting static_call_key however also disallows usage of
static_call(), since objtool needs the key to construct the
static_call_site.

Solve this by allowing objtool to create the static_call_site using
the trampoline address when it builds a module and cannot find the
static_call_key symbol. The module loader will then try and map the
trampole back to a key before it constructs the normal sites list.

Doing this requires a trampoline -> key associsation, so add another
magic section that keeps those.

Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210127231837.ifddpn7rhwdaepiu@treble
---
 arch/x86/include/asm/static_call.h      |  7 +++-
 include/asm-generic/vmlinux.lds.h       |  5 +-
 include/linux/static_call.h             | 22 +++++++++-
 include/linux/static_call_types.h       | 27 +++++++++++-
 kernel/static_call.c                    | 55 +++++++++++++++++++++++-
 tools/include/linux/static_call_types.h | 27 +++++++++++-
 tools/objtool/check.c                   | 17 ++++++-
 7 files changed, 149 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index c37f119..cbb67b6 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -37,4 +37,11 @@
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")
 
+
+#define ARCH_ADD_TRAMP_KEY(name)					\
+	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
+	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
+	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
+	    ".popsection					\n")
+
 #endif /* _ASM_STATIC_CALL_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81..b0871e2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -393,7 +393,10 @@
 	. = ALIGN(8);							\
 	__start_static_call_sites = .;					\
 	KEEP(*(.static_call_sites))					\
-	__stop_static_call_sites = .;
+	__stop_static_call_sites = .;					\
+	__start_static_call_tramp_key = .;				\
+	KEEP(*(.static_call_tramp_key))					\
+	__stop_static_call_tramp_key = .;
 
 /*
  * Allow architectures to handle ro_after_init data on their
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index d69dd8b..85ecc78 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -138,6 +138,12 @@ struct static_call_key {
 	};
 };
 
+/* For finding the key associated with a trampoline */
+struct static_call_tramp_key {
+	s32 tramp;
+	s32 key;
+};
+
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
@@ -165,11 +171,18 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
+/* Leave the key unexported, so modules can't change static call targets: */
+#define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
+	ARCH_ADD_TRAMP_KEY(name)
+#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
+	ARCH_ADD_TRAMP_KEY(name)
+
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
 static inline int static_call_init(void) { return 0; }
@@ -216,11 +229,16 @@ static inline long __static_call_return0(void)
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
+/* Leave the key unexported, so modules can't change static call targets: */
+#define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+
 #else /* Generic implementation */
 
 static inline int static_call_init(void) { return 0; }
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 08f78b1..ae5662d 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -10,6 +10,7 @@
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
 #define STATIC_CALL_KEY_PREFIX_LEN	(sizeof(STATIC_CALL_KEY_PREFIX_STR) - 1)
 #define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_KEY_PREFIX, name)
+#define STATIC_CALL_KEY_STR(name)	__stringify(STATIC_CALL_KEY(name))
 
 #define STATIC_CALL_TRAMP_PREFIX	__SCT__
 #define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
@@ -39,17 +40,39 @@ struct static_call_site {
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
+#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
 /*
  * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
  * the symbol table so that objtool can reference it when it generates the
  * .static_call_sites section.
  */
+#define __STATIC_CALL_ADDRESSABLE(name) \
+	__ADDRESSABLE(STATIC_CALL_KEY(name))
+
 #define __static_call(name)						\
 ({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	__raw_static_call(name);					\
 })
 
+#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#define __STATIC_CALL_ADDRESSABLE(name)
+#define __static_call(name)	__raw_static_call(name)
+
+#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#ifdef MODULE
+#define __STATIC_CALL_MOD_ADDRESSABLE(name)
+#define static_call_mod(name)	__raw_static_call(name)
+#else
+#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define static_call_mod(name)	__static_call(name)
+#endif
+
 #define static_call(name)	__static_call(name)
 
 #else
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 0bc11b5..6906c6e 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -12,6 +12,8 @@
 
 extern struct static_call_site __start_static_call_sites[],
 			       __stop_static_call_sites[];
+extern struct static_call_tramp_key __start_static_call_tramp_key[],
+				    __stop_static_call_tramp_key[];
 
 static bool static_call_initialized;
 
@@ -323,10 +325,59 @@ static int __static_call_mod_text_reserved(void *start, void *end)
 	return ret;
 }
 
+static unsigned long tramp_key_lookup(unsigned long addr)
+{
+	struct static_call_tramp_key *start = __start_static_call_tramp_key;
+	struct static_call_tramp_key *stop = __stop_static_call_tramp_key;
+	struct static_call_tramp_key *tramp_key;
+
+	for (tramp_key = start; tramp_key != stop; tramp_key++) {
+		unsigned long tramp;
+
+		tramp = (long)tramp_key->tramp + (long)&tramp_key->tramp;
+		if (tramp == addr)
+			return (long)tramp_key->key + (long)&tramp_key->key;
+	}
+
+	return 0;
+}
+
 static int static_call_add_module(struct module *mod)
 {
-	return __static_call_init(mod, mod->static_call_sites,
-				  mod->static_call_sites + mod->num_static_call_sites);
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = start + mod->num_static_call_sites;
+	struct static_call_site *site;
+
+	for (site = start; site != stop; site++) {
+		unsigned long addr = (unsigned long)static_call_key(site);
+		unsigned long key;
+
+		/*
+		 * Is the key is exported, 'addr' points to the key, which
+		 * means modules are allowed to call static_call_update() on
+		 * it.
+		 *
+		 * Otherwise, the key isn't exported, and 'addr' points to the
+		 * trampoline so we need to lookup the key.
+		 *
+		 * We go through this dance to prevent crazy modules from
+		 * abusing sensitive static calls.
+		 */
+		if (!kernel_text_address(addr))
+			continue;
+
+		key = tramp_key_lookup(addr);
+		if (!key) {
+			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
+				static_call_addr(site));
+			return -EINVAL;
+		}
+
+		site->key = (key - (long)&site->key) |
+			    (site->key & STATIC_CALL_SITE_FLAGS);
+	}
+
+	return __static_call_init(mod, start, stop);
 }
 
 static void static_call_del_module(struct module *mod)
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 08f78b1..ae5662d 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -10,6 +10,7 @@
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
 #define STATIC_CALL_KEY_PREFIX_LEN	(sizeof(STATIC_CALL_KEY_PREFIX_STR) - 1)
 #define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_KEY_PREFIX, name)
+#define STATIC_CALL_KEY_STR(name)	__stringify(STATIC_CALL_KEY(name))
 
 #define STATIC_CALL_TRAMP_PREFIX	__SCT__
 #define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
@@ -39,17 +40,39 @@ struct static_call_site {
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
+#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
 /*
  * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
  * the symbol table so that objtool can reference it when it generates the
  * .static_call_sites section.
  */
+#define __STATIC_CALL_ADDRESSABLE(name) \
+	__ADDRESSABLE(STATIC_CALL_KEY(name))
+
 #define __static_call(name)						\
 ({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	__raw_static_call(name);					\
 })
 
+#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#define __STATIC_CALL_ADDRESSABLE(name)
+#define __static_call(name)	__raw_static_call(name)
+
+#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#ifdef MODULE
+#define __STATIC_CALL_MOD_ADDRESSABLE(name)
+#define static_call_mod(name)	__raw_static_call(name)
+#else
+#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define static_call_mod(name)	__static_call(name)
+#endif
+
 #define static_call(name)	__static_call(name)
 
 #else
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f8d3ee..7bd96d6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -502,8 +502,21 @@ static int create_static_call_sections(struct objtool_file *file)
 
 		key_sym = find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			WARN("static_call: can't find static_call_key symbol: %s", tmp);
-			return -1;
+			if (!module) {
+				WARN("static_call: can't find static_call_key symbol: %s", tmp);
+				return -1;
+			}
+
+			/*
+			 * For modules(), the key might not be exported, which
+			 * means the module can make static calls but isn't
+			 * allowed to change them.
+			 *
+			 * In that case we temporarily set the key to be the
+			 * trampoline address.  This is fixed up in
+			 * static_call_add_module().
+			 */
+			key_sym = insn->call_dest;
 		}
 		free(key_name);
 
