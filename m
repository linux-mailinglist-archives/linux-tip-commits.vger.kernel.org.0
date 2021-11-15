Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5945160A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Nov 2021 22:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348030AbhKOVH7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 16:07:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349369AbhKOUMH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:12:07 -0500
Date:   Mon, 15 Nov 2021 20:09:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637006950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCWCtJirk7NfWGlMkDiZHZ2/fzGZjhNO1704SJFY7LQ=;
        b=1cO0tPjItm3qpUDrzKREV/QLOykT1owuzdT54DLjuRFlF/Vw5+sK2WbTvOSGtmkTBRYa8U
        97vxOQhDixLQ5n5HvkRsV1+NfO2KQnceo1Z3PSSwRiW4GjMPlSnWrifCmPkwsmOJ9QI28A
        fU5CMyl7iskZXU1Geo281KeWDTkxm2HnpqQhbMZVQ3B+SO8OUL5uQwu6Kk53gaWTXZa+UI
        eMq0Pr6bilgypzwohoRGEI4YEqvyJwOqkTpfJkkgnOvB43hiK9epZZpVss1aiTrNv1yqEU
        cYPcKcgvYUmjvUHoueDkSuYeRJddtEISxSv+75n6UL1qnKI2SjXBQE1MeYhmRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637006950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCWCtJirk7NfWGlMkDiZHZ2/fzGZjhNO1704SJFY7LQ=;
        b=nd4xDx2oCmFrSG9KyPUSPwqScVjcjt1MwDrJzOnoshrJHfkGX2G0VEIIw/lN8W7EAVNtfW
        wX8lb+cCCK+AdYCA==
From:   "tip-bot2 for Lucas De Marchi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] drm/i915/gem: Stop using PAGE_KERNEL_IO
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211020090625.1037517-1-lucas.demarchi@intel.com>
References: <20211020090625.1037517-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Message-ID: <163700694919.414.15045515173084346246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6b2a2138cf36e67783884058c772bfeb63a999ad
Gitweb:        https://git.kernel.org/tip/6b2a2138cf36e67783884058c772bfeb63a999ad
Author:        Lucas De Marchi <lucas.demarchi@intel.com>
AuthorDate:    Thu, 21 Oct 2021 11:15:10 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 10:31:49 -08:00

drm/i915/gem: Stop using PAGE_KERNEL_IO

PAGE_KERNEL_IO is only defined for x86 and nowadays is the same as
PAGE_KERNEL. It was different for some time, OR'ing a `_PAGE_IOMAP` flag
in commit be43d72835ba ("x86: add _PAGE_IOMAP pte flag for IO
mappings").  This got removed in commit f955371ca9d3 ("x86: remove the
Xen-specific _PAGE_IOMAP PTE flag"), so today they are just the same.

This is the same that was done in commit ac96b5566926 ("io-mapping.h:
s/PAGE_KERNEL_IO/PAGE_KERNEL/").

There is a subsequent commit with
'Fixes: ac96b5566926 ("io-mapping.h: s/PAGE_KERNEL_IO/PAGE_KERNEL/")' -
but that is not relevant here since is it's actually fixing the different
names for pgprot_writecombine(), which we also don't have today since
all archs expose pgprot_writecombine(). Microblaze, mentioned in that
discussion, gained pgprot_writecombine() in
commit 97ccedd793ac ("microblaze: Provide pgprot_device/writecombine
macros for nommu").

So, just use PAGE_KERNEL, and just use pgprot_writecombine().

Link: https://patchwork.freedesktop.org/patch/msgid/20211020090625.1037517-1-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20211021181511.1533377-2-lucas.demarchi@intel.com
---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 8eb1c3a..68fe183 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -289,7 +289,7 @@ static void *i915_gem_object_map_page(struct drm_i915_gem_object *obj,
 		pgprot = PAGE_KERNEL;
 		break;
 	case I915_MAP_WC:
-		pgprot = pgprot_writecombine(PAGE_KERNEL_IO);
+		pgprot = pgprot_writecombine(PAGE_KERNEL);
 		break;
 	}
 
@@ -333,7 +333,7 @@ static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
 	i = 0;
 	for_each_sgt_daddr(addr, iter, obj->mm.pages)
 		pfns[i++] = (iomap + addr) >> PAGE_SHIFT;
-	vaddr = vmap_pfn(pfns, n_pfn, pgprot_writecombine(PAGE_KERNEL_IO));
+	vaddr = vmap_pfn(pfns, n_pfn, pgprot_writecombine(PAGE_KERNEL));
 	if (pfns != stack)
 		kvfree(pfns);
 
