Return-Path: <linux-tip-commits+bounces-7798-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F1CF49C2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751C631B784F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B3346A11;
	Mon,  5 Jan 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jNblvybG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2HL6btmv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C333ADA2;
	Mon,  5 Jan 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628469; cv=none; b=KxM7N7AkSfIH5kFOCTpIDs1HBc/dgdBjrB5ieGtCom5fP9GTFg0nWqoaNqzFxJAoGy53gJfiGa9s//QDFZkQA1A/Tfv5jpVuvccYbrP7U/LfSPriq48fQm0FXkfFGBZnC0YLDL3q/4FHEPhGHR4XQkJkbdQcSAp+MxKPvlkYxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628469; c=relaxed/simple;
	bh=dTVsb5Vbvje4+1oUis2pCqF3h8HKssDDNaqB1LmDaFc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mksex8BnKFa/7MBxRGcwO32PxQJ5D768NINDm/GelVsmNMKYfu3rPFjYUSZf0O943n0rZZ8d9dQxAre2XUeej47lqdtNEv6+v7s43sENCxT7fZikDpqqf3KtVxzPWM+GW4Ox/VnK8T9WZ/fHrQ/4u0OyVv98xXrB9qBmxWgCCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jNblvybG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2HL6btmv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SMjPiDQV07TQri4n0ogGtplUEZW/RbDWKwYMAqHyo0=;
	b=jNblvybGVbk7Tc4pCmo5mErhIPsWwn0tBEF3QqI6g2yNvP6tK+TIDj6GXP5D3pXFqbKIeW
	sbCZSlXf+HPpkWyq0gbYc0164506Wt0fBpr+E/iDJOVB6Lb/bQZFTRkp7OQBmAK1ORU/sR
	Njl1NQ68c1+6KzKBBlywni1G06iPAX9o9fXQSdpbXu5FxM0Ao6vroprtLU6x+A6YTT8Vt6
	GRqrM+LX8+cwKtoQzv+umSBx1zBzePR9koNmw1XGI6znO4y/w0+s/2StU8FK4d91wdfAP8
	vpigKIG4oOjiwmdD5vz/u3lvqI4EBRg26neZ6m5ho8Ke9rQWWaYmU5dN0Y/3Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SMjPiDQV07TQri4n0ogGtplUEZW/RbDWKwYMAqHyo0=;
	b=2HL6btmvdCl4AQdvZhe7UhOAy5Icb56gc9/NOLfP4eLbPlORLRb+qJecaZYDYKGWPFiL8O
	20oLJCjzJkPGgkBQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] compiler-context-analysis: Remove __cond_lock()
 function-like helper
Cc: Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-25-elver@google.com>
References: <20251219154418.3592607-25-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846319.510.4635081717236996961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e4588c25c9d122b5847b88e18b184404b6959160
Gitweb:        https://git.kernel.org/tip/e4588c25c9d122b5847b88e18b184404b69=
59160
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:33 +01:00

compiler-context-analysis: Remove __cond_lock() function-like helper

As discussed in [1], removing __cond_lock() will improve the readability
of trylock code. Now that Sparse context tracking support has been
removed, we can also remove __cond_lock().

Change existing APIs to either drop __cond_lock() completely, or make
use of the __cond_acquires() function attribute instead.

In particular, spinlock and rwlock implementations required switching
over to inline helpers rather than statement-expressions for their
trylock_* variants.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250207082832.GU7145@noisy.programming.kic=
ks-ass.net/ [1]
Link: https://patch.msgid.link/20251219154418.3592607-25-elver@google.com
---
 Documentation/dev-tools/context-analysis.rst              |  2 +-
 Documentation/mm/process_addrs.rst                        |  6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c            |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h            |  6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h |  5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c    |  4 +-
 include/linux/compiler-context-analysis.h                 | 31 +----
 include/linux/lockref.h                                   |  4 +-
 include/linux/mm.h                                        | 33 +----
 include/linux/rwlock.h                                    | 11 +-
 include/linux/rwlock_api_smp.h                            | 14 +-
 include/linux/rwlock_rt.h                                 | 21 +-
 include/linux/sched/signal.h                              | 14 +--
 include/linux/spinlock.h                                  | 45 +----
 include/linux/spinlock_api_smp.h                          | 20 ++-
 include/linux/spinlock_api_up.h                           | 61 +++++--
 include/linux/spinlock_rt.h                               | 26 +--
 kernel/signal.c                                           |  4 +-
 kernel/time/posix-timers.c                                | 13 +-
 lib/dec_and_lock.c                                        |  8 +-
 lib/lockref.c                                             |  1 +-
 mm/memory.c                                               |  4 +-
 mm/pgtable-generic.c                                      | 19 +--
 tools/include/linux/compiler_types.h                      |  2 +-
 24 files changed, 163 insertions(+), 195 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev=
-tools/context-analysis.rst
index 8dd6c0d..e69896e 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -112,10 +112,8 @@ Keywords
                  __releases_shared
                  __acquire
                  __release
-                 __cond_lock
                  __acquire_shared
                  __release_shared
-                 __cond_lock_shared
                  __acquire_ret
                  __acquire_shared_ret
                  context_unsafe
diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_ad=
drs.rst
index 7f2f3e8..851680e 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -583,7 +583,7 @@ To access PTE-level page tables, a helper like :c:func:`!=
pte_offset_map_lock` or
 :c:func:`!pte_offset_map` can be used depending on stability requirements.
 These map the page table into kernel memory if required, take the RCU lock, =
and
 depending on variant, may also look up or acquire the PTE lock.
-See the comment on :c:func:`!__pte_offset_map_lock`.
+See the comment on :c:func:`!pte_offset_map_lock`.
=20
 Atomicity
 ^^^^^^^^^
@@ -667,7 +667,7 @@ must be released via :c:func:`!pte_unmap_unlock`.
 .. note:: There are some variants on this, such as
    :c:func:`!pte_offset_map_rw_nolock` when we know we hold the PTE stable b=
ut
    for brevity we do not explore this.  See the comment for
-   :c:func:`!__pte_offset_map_lock` for more details.
+   :c:func:`!pte_offset_map_lock` for more details.
=20
 When modifying data in ranges we typically only wish to allocate higher page
 tables as necessary, using these locks to avoid races or overwriting anythin=
g,
@@ -686,7 +686,7 @@ At the leaf page table, that is the PTE, we can't entirel=
y rely on this pattern
 as we have separate PMD and PTE locks and a THP collapse for instance might =
have
 eliminated the PMD entry as well as the PTE from under us.
=20
-This is why :c:func:`!__pte_offset_map_lock` locklessly retrieves the PMD en=
try
+This is why :c:func:`!pte_offset_map_lock` locklessly retrieves the PMD entry
 for the PTE, carefully checking it is as expected, before acquiring the
 PTE-specific lock, and then *again* checking that the PMD entry is as expect=
ed.
=20
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wir=
eless/intel/iwlwifi/iwl-trans.c
index cc8a840..fa14422 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -548,11 +548,11 @@ int iwl_trans_read_config32(struct iwl_trans *trans, u3=
2 ofs,
 	return iwl_trans_pcie_read_config32(trans, ofs, val);
 }
=20
-bool _iwl_trans_grab_nic_access(struct iwl_trans *trans)
+bool iwl_trans_grab_nic_access(struct iwl_trans *trans)
 {
 	return iwl_trans_pcie_grab_nic_access(trans);
 }
-IWL_EXPORT_SYMBOL(_iwl_trans_grab_nic_access);
+IWL_EXPORT_SYMBOL(iwl_trans_grab_nic_access);
=20
 void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wir=
eless/intel/iwlwifi/iwl-trans.h
index a552669..688f9fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1063,11 +1063,7 @@ int iwl_trans_sw_reset(struct iwl_trans *trans);
 void iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg,
 			     u32 mask, u32 value);
=20
-bool _iwl_trans_grab_nic_access(struct iwl_trans *trans);
-
-#define iwl_trans_grab_nic_access(trans)		\
-	__cond_lock(nic_access,				\
-		    likely(_iwl_trans_grab_nic_access(trans)))
+bool iwl_trans_grab_nic_access(struct iwl_trans *trans);
=20
 void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/driv=
ers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 207c56e..7b7b35e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -553,10 +553,7 @@ void iwl_trans_pcie_free(struct iwl_trans *trans);
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_reg=
ions,
 					   struct device *dev);
=20
-bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent);
-#define _iwl_trans_pcie_grab_nic_access(trans, silent)		\
-	__cond_lock(nic_access_nobh,				\
-		    likely(__iwl_trans_pcie_grab_nic_access(trans, silent)))
+bool _iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent);
=20
 void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev);
 void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers=
/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 164d060..415a19e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -2327,7 +2327,7 @@ EXPORT_SYMBOL(iwl_trans_pcie_reset);
  * This version doesn't disable BHs but rather assumes they're
  * already disabled.
  */
-bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
+bool _iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
 {
 	int ret;
 	struct iwl_trans_pcie *trans_pcie =3D IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -2415,7 +2415,7 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *t=
rans)
 	bool ret;
=20
 	local_bh_disable();
-	ret =3D __iwl_trans_pcie_grab_nic_access(trans, false);
+	ret =3D _iwl_trans_pcie_grab_nic_access(trans, false);
 	if (ret) {
 		/* keep BHs disabled until iwl_trans_pcie_release_nic_access */
 		return ret;
diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compil=
er-context-analysis.h
index cb72882..4f7559d 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -342,24 +342,6 @@ static inline void _context_unsafe_alias(void **p) { }
 #define __release(x)		__release_ctx_lock(x)
=20
 /**
- * __cond_lock() - function that conditionally acquires a context lock
- *                 exclusively
- * @x: context lock instance pinter
- * @c: boolean expression
- *
- * Return: result of @c
- *
- * No-op function that conditionally acquires context lock instance @x
- * exclusively, if the boolean expression @c is true. The result of @c is the
- * return value; for example:
- *
- * .. code-block:: c
- *
- *	#define spin_trylock(l) __cond_lock(&lock, _spin_trylock(&lock))
- */
-#define __cond_lock(x, c)	__try_acquire_ctx_lock(x, c)
-
-/**
  * __must_hold_shared() - function attribute, caller must hold shared contex=
t lock
  *
  * Function attribute declaring that the caller must hold the given context
@@ -418,19 +400,6 @@ static inline void _context_unsafe_alias(void **p) { }
 #define __release_shared(x)	__release_shared_ctx_lock(x)
=20
 /**
- * __cond_lock_shared() - function that conditionally acquires a context loc=
k shared
- * @x: context lock instance pinter
- * @c: boolean expression
- *
- * Return: result of @c
- *
- * No-op function that conditionally acquires context lock instance @x with
- * shared access, if the boolean expression @c is true. The result of @c is =
the
- * return value.
- */
-#define __cond_lock_shared(x, c) __try_acquire_shared_ctx_lock(x, c)
-
-/**
  * __acquire_ret() - helper to acquire context lock of return value
  * @call: call expression
  * @ret_expr: acquire expression that uses __ret
diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index 815d871..6ded24c 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -49,9 +49,7 @@ static inline void lockref_init(struct lockref *lockref)
 void lockref_get(struct lockref *lockref);
 int lockref_put_return(struct lockref *lockref);
 bool lockref_get_not_zero(struct lockref *lockref);
-bool lockref_put_or_lock(struct lockref *lockref);
-#define lockref_put_or_lock(_lockref) \
-	(!__cond_lock((_lockref)->lock, !lockref_put_or_lock(_lockref)))
+bool lockref_put_or_lock(struct lockref *lockref) __cond_acquires(false, &lo=
ckref->lock);
=20
 void lockref_mark_dead(struct lockref *lockref);
 bool lockref_get_not_dead(struct lockref *lockref);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1507626..f369cb6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2975,15 +2975,8 @@ static inline pud_t pud_mkspecial(pud_t pud)
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
=20
-extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
-			       spinlock_t **ptl);
-static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
-				    spinlock_t **ptl)
-{
-	pte_t *ptep;
-	__cond_lock(*ptl, ptep =3D __get_locked_pte(mm, addr, ptl));
-	return ptep;
-}
+extern pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
+			     spinlock_t **ptl);
=20
 #ifdef __PAGETABLE_P4D_FOLDED
 static inline int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
@@ -3337,31 +3330,15 @@ static inline bool pagetable_pte_ctor(struct mm_struc=
t *mm,
 	return true;
 }
=20
-pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
-static inline pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr,
-			pmd_t *pmdvalp)
-{
-	pte_t *pte;
+pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
=20
-	__cond_lock(RCU, pte =3D ___pte_offset_map(pmd, addr, pmdvalp));
-	return pte;
-}
 static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
 {
 	return __pte_offset_map(pmd, addr, NULL);
 }
=20
-pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp);
-static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp)
-{
-	pte_t *pte;
-
-	__cond_lock(RCU, __cond_lock(*ptlp,
-			pte =3D __pte_offset_map_lock(mm, pmd, addr, ptlp)));
-	return pte;
-}
+pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+			   unsigned long addr, spinlock_t **ptlp);
=20
 pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, spinlock_t **ptlp);
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 151f9d5..65a5b55 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -50,8 +50,8 @@ do {								\
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define read_trylock(lock)	__cond_lock_shared(lock, _raw_read_trylock(lock))
-#define write_trylock(lock)	__cond_lock(lock, _raw_write_trylock(lock))
+#define read_trylock(lock)	_raw_read_trylock(lock)
+#define write_trylock(lock)	_raw_write_trylock(lock)
=20
 #define write_lock(lock)	_raw_write_lock(lock)
 #define read_lock(lock)		_raw_read_lock(lock)
@@ -113,12 +113,7 @@ do {								\
 	} while (0)
 #define write_unlock_bh(lock)		_raw_write_unlock_bh(lock)
=20
-#define write_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, ({				\
-		local_irq_save(flags);			\
-		_raw_write_trylock(lock) ?		\
-		1 : ({ local_irq_restore(flags); 0; });	\
-	}))
+#define write_trylock_irqsave(lock, flags) _raw_write_trylock_irqsave(lock, =
&(flags))
=20
 #ifdef arch_rwlock_is_contended
 #define rwlock_is_contended(lock) \
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index 6d5cc0b..d903b17 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -26,8 +26,8 @@ unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *l=
ock)
 							__acquires(lock);
 unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
-int __lockfunc _raw_read_trylock(rwlock_t *lock);
-int __lockfunc _raw_write_trylock(rwlock_t *lock);
+int __lockfunc _raw_read_trylock(rwlock_t *lock)	__cond_acquires_shared(true=
, lock);
+int __lockfunc _raw_write_trylock(rwlock_t *lock)	__cond_acquires(true, lock=
);
 void __lockfunc _raw_read_unlock(rwlock_t *lock)	__releases_shared(lock);
 void __lockfunc _raw_write_unlock(rwlock_t *lock)	__releases(lock);
 void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)	__releases_shared(lock);
@@ -41,6 +41,16 @@ void __lockfunc
 _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
=20
+static inline bool _raw_write_trylock_irqsave(rwlock_t *lock, unsigned long =
*flags)
+	__cond_acquires(true, lock)
+{
+	local_irq_save(*flags);
+	if (_raw_write_trylock(lock))
+		return true;
+	local_irq_restore(*flags);
+	return false;
+}
+
 #ifdef CONFIG_INLINE_READ_LOCK
 #define _raw_read_lock(lock) __raw_read_lock(lock)
 #endif
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index f64d6d3..37b387d 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -26,11 +26,11 @@ do {							\
 } while (0)
=20
 extern void rt_read_lock(rwlock_t *rwlock)	__acquires_shared(rwlock);
-extern int rt_read_trylock(rwlock_t *rwlock);
+extern int rt_read_trylock(rwlock_t *rwlock)	__cond_acquires_shared(true, rw=
lock);
 extern void rt_read_unlock(rwlock_t *rwlock)	__releases_shared(rwlock);
 extern void rt_write_lock(rwlock_t *rwlock)	__acquires(rwlock);
 extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass)	__acquires(=
rwlock);
-extern int rt_write_trylock(rwlock_t *rwlock);
+extern int rt_write_trylock(rwlock_t *rwlock)	__cond_acquires(true, rwlock);
 extern void rt_write_unlock(rwlock_t *rwlock)	__releases(rwlock);
=20
 static __always_inline void read_lock(rwlock_t *rwlock)
@@ -59,7 +59,7 @@ static __always_inline void read_lock_irq(rwlock_t *rwlock)
 		flags =3D 0;				\
 	} while (0)
=20
-#define read_trylock(lock)	__cond_lock_shared(lock, rt_read_trylock(lock))
+#define read_trylock(lock)	rt_read_trylock(lock)
=20
 static __always_inline void read_unlock(rwlock_t *rwlock)
 	__releases_shared(rwlock)
@@ -123,14 +123,15 @@ static __always_inline void write_lock_irq(rwlock_t *rw=
lock)
 		flags =3D 0;				\
 	} while (0)
=20
-#define write_trylock(lock)	__cond_lock(lock, rt_write_trylock(lock))
+#define write_trylock(lock)	rt_write_trylock(lock)
=20
-#define write_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, ({				\
-		typecheck(unsigned long, flags);	\
-		flags =3D 0;				\
-		rt_write_trylock(lock);			\
-	}))
+static __always_inline bool _write_trylock_irqsave(rwlock_t *rwlock, unsigne=
d long *flags)
+	__cond_acquires(true, rwlock)
+{
+	*flags =3D 0;
+	return rt_write_trylock(rwlock);
+}
+#define write_trylock_irqsave(lock, flags) _write_trylock_irqsave(lock, &(fl=
ags))
=20
 static __always_inline void write_unlock(rwlock_t *rwlock)
 	__releases(rwlock)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7d64499..a63f65a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -737,18 +737,8 @@ static inline int thread_group_empty(struct task_struct =
*p)
 #define delay_group_leader(p) \
 		(thread_group_leader(p) && !thread_group_empty(p))
=20
-extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
-							unsigned long *flags);
-
-static inline struct sighand_struct *lock_task_sighand(struct task_struct *t=
ask,
-						       unsigned long *flags)
-{
-	struct sighand_struct *ret;
-
-	ret =3D __lock_task_sighand(task, flags);
-	(void)__cond_lock(&task->sighand->siglock, ret);
-	return ret;
-}
+extern struct sighand_struct *lock_task_sighand(struct task_struct *task,
+						unsigned long *flags);
=20
 static inline void unlock_task_sighand(struct task_struct *task,
 						unsigned long *flags)
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 7e560c7..396b8c5 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -213,7 +213,7 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *loc=
k) __releases(lock)
  * various methods are defined as nops in the case they are not
  * required.
  */
-#define raw_spin_trylock(lock)	__cond_lock(lock, _raw_spin_trylock(lock))
+#define raw_spin_trylock(lock)	_raw_spin_trylock(lock)
=20
 #define raw_spin_lock(lock)	_raw_spin_lock(lock)
=20
@@ -284,22 +284,11 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *l=
ock) __releases(lock)
 	} while (0)
 #define raw_spin_unlock_bh(lock)	_raw_spin_unlock_bh(lock)
=20
-#define raw_spin_trylock_bh(lock) \
-	__cond_lock(lock, _raw_spin_trylock_bh(lock))
+#define raw_spin_trylock_bh(lock)	_raw_spin_trylock_bh(lock)
=20
-#define raw_spin_trylock_irq(lock)			\
-	__cond_lock(lock, ({				\
-		local_irq_disable();			\
-		_raw_spin_trylock(lock) ?		\
-		1 : ({ local_irq_enable(); 0;  });	\
-	}))
+#define raw_spin_trylock_irq(lock)	_raw_spin_trylock_irq(lock)
=20
-#define raw_spin_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, ({				\
-		local_irq_save(flags);			\
-		_raw_spin_trylock(lock) ?		\
-		1 : ({ local_irq_restore(flags); 0; }); \
-	}))
+#define raw_spin_trylock_irqsave(lock, flags) _raw_spin_trylock_irqsave(lock=
, &(flags))
=20
 #ifndef CONFIG_PREEMPT_RT
 /* Include rwlock functions for !RT */
@@ -433,8 +422,12 @@ static __always_inline int spin_trylock_irq(spinlock_t *=
lock)
 	return raw_spin_trylock_irq(&lock->rlock);
 }
=20
-#define spin_trylock_irqsave(lock, flags)			\
-	__cond_lock(lock, raw_spin_trylock_irqsave(spinlock_check(lock), flags))
+static __always_inline bool _spin_trylock_irqsave(spinlock_t *lock, unsigned=
 long *flags)
+	__cond_acquires(true, lock) __no_context_analysis
+{
+	return raw_spin_trylock_irqsave(spinlock_check(lock), *flags);
+}
+#define spin_trylock_irqsave(lock, flags) _spin_trylock_irqsave(lock, &(flag=
s))
=20
 /**
  * spin_is_locked() - Check whether a spinlock is locked.
@@ -512,23 +505,17 @@ static inline int rwlock_needbreak(rwlock_t *lock)
  * Decrements @atomic by 1.  If the result is 0, returns true and locks
  * @lock.  Returns false for all other cases.
  */
-extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
-#define atomic_dec_and_lock(atomic, lock) \
-		__cond_lock(lock, _atomic_dec_and_lock(atomic, lock))
+extern int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock) __cond_ac=
quires(true, lock);
=20
 extern int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
-					unsigned long *flags);
-#define atomic_dec_and_lock_irqsave(atomic, lock, flags) \
-		__cond_lock(lock, _atomic_dec_and_lock_irqsave(atomic, lock, &(flags)))
+					unsigned long *flags) __cond_acquires(true, lock);
+#define atomic_dec_and_lock_irqsave(atomic, lock, flags) _atomic_dec_and_loc=
k_irqsave(atomic, lock, &(flags))
=20
-extern int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock);
-#define atomic_dec_and_raw_lock(atomic, lock) \
-		__cond_lock(lock, _atomic_dec_and_raw_lock(atomic, lock))
+extern int atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock) _=
_cond_acquires(true, lock);
=20
 extern int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t=
 *lock,
-					unsigned long *flags);
-#define atomic_dec_and_raw_lock_irqsave(atomic, lock, flags) \
-		__cond_lock(lock, _atomic_dec_and_raw_lock_irqsave(atomic, lock, &(flags)))
+					    unsigned long *flags) __cond_acquires(true, lock);
+#define atomic_dec_and_raw_lock_irqsave(atomic, lock, flags) _atomic_dec_and=
_raw_lock_irqsave(atomic, lock, &(flags))
=20
 int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 			     size_t max_size, unsigned int cpu_mult,
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_sm=
p.h
index 7e7d7d3..bda5e7a 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -95,6 +95,26 @@ static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 	return 0;
 }
=20
+static __always_inline bool _raw_spin_trylock_irq(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	local_irq_disable();
+	if (_raw_spin_trylock(lock))
+		return true;
+	local_irq_enable();
+	return false;
+}
+
+static __always_inline bool _raw_spin_trylock_irqsave(raw_spinlock_t *lock, =
unsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	local_irq_save(*flags);
+	if (_raw_spin_trylock(lock))
+		return true;
+	local_irq_restore(*flags);
+	return false;
+}
+
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
  * even on CONFIG_PREEMPTION, because lockdep assumes that interrupts are
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index 018f5aa..a9d5c7c 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -24,14 +24,11 @@
  * flags straight, to suppress compiler warnings of unused lock
  * variables, and to add the proper checker annotations:
  */
-#define ___LOCK_void(lock) \
-  do { (void)(lock); } while (0)
-
 #define ___LOCK_(lock) \
-  do { __acquire(lock); ___LOCK_void(lock); } while (0)
+  do { __acquire(lock); (void)(lock); } while (0)
=20
 #define ___LOCK_shared(lock) \
-  do { __acquire_shared(lock); ___LOCK_void(lock); } while (0)
+  do { __acquire_shared(lock); (void)(lock); } while (0)
=20
 #define __LOCK(lock, ...) \
   do { preempt_disable(); ___LOCK_##__VA_ARGS__(lock); } while (0)
@@ -78,10 +75,56 @@
 #define _raw_spin_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
 #define _raw_read_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags, shar=
ed)
 #define _raw_write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
-#define _raw_spin_trylock(lock)			({ __LOCK(lock, void); 1; })
-#define _raw_read_trylock(lock)			({ __LOCK(lock, void); 1; })
-#define _raw_write_trylock(lock)			({ __LOCK(lock, void); 1; })
-#define _raw_spin_trylock_bh(lock)		({ __LOCK_BH(lock, void); 1; })
+
+static __always_inline int _raw_spin_trylock(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK(lock);
+	return 1;
+}
+
+static __always_inline int _raw_spin_trylock_bh(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK_BH(lock);
+	return 1;
+}
+
+static __always_inline int _raw_spin_trylock_irq(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK_IRQ(lock);
+	return 1;
+}
+
+static __always_inline int _raw_spin_trylock_irqsave(raw_spinlock_t *lock, u=
nsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	__LOCK_IRQSAVE(lock, *(flags));
+	return 1;
+}
+
+static __always_inline int _raw_read_trylock(rwlock_t *lock)
+	__cond_acquires_shared(true, lock)
+{
+	__LOCK(lock, shared);
+	return 1;
+}
+
+static __always_inline int _raw_write_trylock(rwlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK(lock);
+	return 1;
+}
+
+static __always_inline int _raw_write_trylock_irqsave(rwlock_t *lock, unsign=
ed long *flags)
+	__cond_acquires(true, lock)
+{
+	__LOCK_IRQSAVE(lock, *(flags));
+	return 1;
+}
+
 #define _raw_spin_unlock(lock)			__UNLOCK(lock)
 #define _raw_read_unlock(lock)			__UNLOCK(lock, shared)
 #define _raw_write_unlock(lock)			__UNLOCK(lock)
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 6bab73e..0a58576 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -37,8 +37,8 @@ extern void rt_spin_lock_nested(spinlock_t *lock, int subcl=
ass)	__acquires(lock)
 extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nes=
t_lock) __acquires(lock);
 extern void rt_spin_unlock(spinlock_t *lock)	__releases(lock);
 extern void rt_spin_lock_unlock(spinlock_t *lock);
-extern int rt_spin_trylock_bh(spinlock_t *lock);
-extern int rt_spin_trylock(spinlock_t *lock);
+extern int rt_spin_trylock_bh(spinlock_t *lock) __cond_acquires(true, lock);
+extern int rt_spin_trylock(spinlock_t *lock) __cond_acquires(true, lock);
=20
 static __always_inline void spin_lock(spinlock_t *lock)
 	__acquires(lock)
@@ -130,21 +130,19 @@ static __always_inline void spin_unlock_irqrestore(spin=
lock_t *lock,
 	rt_spin_unlock(lock);
 }
=20
-#define spin_trylock(lock)				\
-	__cond_lock(lock, rt_spin_trylock(lock))
+#define spin_trylock(lock)	rt_spin_trylock(lock)
=20
-#define spin_trylock_bh(lock)				\
-	__cond_lock(lock, rt_spin_trylock_bh(lock))
+#define spin_trylock_bh(lock)	rt_spin_trylock_bh(lock)
=20
-#define spin_trylock_irq(lock)				\
-	__cond_lock(lock, rt_spin_trylock(lock))
+#define spin_trylock_irq(lock)	rt_spin_trylock(lock)
=20
-#define spin_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, ({				\
-		typecheck(unsigned long, flags);	\
-		flags =3D 0;				\
-		rt_spin_trylock(lock);			\
-	}))
+static __always_inline bool _spin_trylock_irqsave(spinlock_t *lock, unsigned=
 long *flags)
+	__cond_acquires(true, lock)
+{
+	*flags =3D 0;
+	return rt_spin_trylock(lock);
+}
+#define spin_trylock_irqsave(lock, flags) _spin_trylock_irqsave(lock, &(flag=
s))
=20
 #define spin_is_contended(lock)		(((void)(lock), 0))
=20
diff --git a/kernel/signal.c b/kernel/signal.c
index e42b8bd..d65d0fe 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1355,8 +1355,8 @@ int zap_other_threads(struct task_struct *p)
 	return count;
 }
=20
-struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
-					   unsigned long *flags)
+struct sighand_struct *lock_task_sighand(struct task_struct *tsk,
+					 unsigned long *flags)
 {
 	struct sighand_struct *sighand;
=20
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 80a8a09..413e238 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -66,14 +66,7 @@ static const struct k_clock clock_realtime, clock_monotoni=
c;
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
=20
-static struct k_itimer *__lock_timer(timer_t timer_id);
-
-#define lock_timer(tid)							\
-({	struct k_itimer *__timr;					\
-	__cond_lock(&__timr->it_lock, __timr =3D __lock_timer(tid));	\
-	__timr;								\
-})
-
+static struct k_itimer *lock_timer(timer_t timer_id);
 static inline void unlock_timer(struct k_itimer *timr)
 {
 	if (likely((timr)))
@@ -85,7 +78,7 @@ static inline void unlock_timer(struct k_itimer *timr)
=20
 #define scoped_timer				(scope)
=20
-DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), __lock_timer(i=
d), timer_t id);
+DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), lock_timer(id)=
, timer_t id);
 DEFINE_CLASS_IS_COND_GUARD(lock_timer);
=20
 static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsi=
gned int nr)
@@ -600,7 +593,7 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clockid_t, which_clo=
ck,
 }
 #endif
=20
-static struct k_itimer *__lock_timer(timer_t timer_id)
+static struct k_itimer *lock_timer(timer_t timer_id)
 {
 	struct k_itimer *timr;
=20
diff --git a/lib/dec_and_lock.c b/lib/dec_and_lock.c
index 1dcca8f..8c7c398 100644
--- a/lib/dec_and_lock.c
+++ b/lib/dec_and_lock.c
@@ -18,7 +18,7 @@
  * because the spin-lock and the decrement must be
  * "atomic".
  */
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
 	if (atomic_add_unless(atomic, -1, 1))
@@ -32,7 +32,7 @@ int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 	return 0;
 }
=20
-EXPORT_SYMBOL(_atomic_dec_and_lock);
+EXPORT_SYMBOL(atomic_dec_and_lock);
=20
 int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
 				 unsigned long *flags)
@@ -50,7 +50,7 @@ int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock=
_t *lock,
 }
 EXPORT_SYMBOL(_atomic_dec_and_lock_irqsave);
=20
-int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock)
+int atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock)
 {
 	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
 	if (atomic_add_unless(atomic, -1, 1))
@@ -63,7 +63,7 @@ int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock=
_t *lock)
 	raw_spin_unlock(lock);
 	return 0;
 }
-EXPORT_SYMBOL(_atomic_dec_and_raw_lock);
+EXPORT_SYMBOL(atomic_dec_and_raw_lock);
=20
 int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
 				     unsigned long *flags)
diff --git a/lib/lockref.c b/lib/lockref.c
index 9210fc6..5d8e3ef 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -105,7 +105,6 @@ EXPORT_SYMBOL(lockref_put_return);
  * @lockref: pointer to lockref structure
  * Return: 1 if count updated successfully or 0 if count <=3D 1 and lock tak=
en
  */
-#undef lockref_put_or_lock
 bool lockref_put_or_lock(struct lockref *lockref)
 {
 	CMPXCHG_LOOP(
diff --git a/mm/memory.c b/mm/memory.c
index 2a55edc..b751e1f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2210,8 +2210,8 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigne=
d long addr)
 	return pmd;
 }
=20
-pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
-			spinlock_t **ptl)
+pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
+		      spinlock_t **ptl)
 {
 	pmd_t *pmd =3D walk_to_pmd(mm, addr);
=20
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index d3aec7a..af79661 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -280,7 +280,7 @@ static unsigned long pmdp_get_lockless_start(void) { retu=
rn 0; }
 static void pmdp_get_lockless_end(unsigned long irqflags) { }
 #endif
=20
-pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
+pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 {
 	unsigned long irqflags;
 	pmd_t pmdval;
@@ -332,13 +332,12 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, p=
md_t *pmd,
 }
=20
 /*
- * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal implementation
- * __pte_offset_map_lock() below, is usually called with the pmd pointer for
- * addr, reached by walking down the mm's pgd, p4d, pud for addr: either whi=
le
- * holding mmap_lock or vma lock for read or for write; or in truncate or rm=
ap
- * context, while holding file's i_mmap_lock or anon_vma lock for read (or f=
or
- * write). In a few cases, it may be used with pmd pointing to a pmd_t alrea=
dy
- * copied to or constructed on the stack.
+ * pte_offset_map_lock(mm, pmd, addr, ptlp) is usually called with the pmd
+ * pointer for addr, reached by walking down the mm's pgd, p4d, pud for addr:
+ * either while holding mmap_lock or vma lock for read or for write; or in
+ * truncate or rmap context, while holding file's i_mmap_lock or anon_vma lo=
ck
+ * for read (or for write). In a few cases, it may be used with pmd pointing=
 to
+ * a pmd_t already copied to or constructed on the stack.
  *
  * When successful, it returns the pte pointer for addr, with its page table
  * kmapped if necessary (when CONFIG_HIGHPTE), and locked against concurrent
@@ -389,8 +388,8 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd=
_t *pmd,
  * table, and may not use RCU at all: "outsiders" like khugepaged should avo=
id
  * pte_offset_map() and co once the vma is detached from mm or mm_users is z=
ero.
  */
-pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
-			     unsigned long addr, spinlock_t **ptlp)
+pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+			   unsigned long addr, spinlock_t **ptlp)
 {
 	spinlock_t *ptl;
 	pmd_t pmdval;
diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compi=
ler_types.h
index d09f9dc..067a5b4 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -20,7 +20,6 @@
 # define __releases(x)	__attribute__((context(x,1,0)))
 # define __acquire(x)	__context__(x,1)
 # define __release(x)	__context__(x,-1)
-# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 #else /* __CHECKER__ */
 /* context/locking */
 # define __must_hold(x)
@@ -28,7 +27,6 @@
 # define __releases(x)
 # define __acquire(x)	(void)0
 # define __release(x)	(void)0
-# define __cond_lock(x,c) (c)
 #endif /* __CHECKER__ */
=20
 /* Compiler specific macros. */

