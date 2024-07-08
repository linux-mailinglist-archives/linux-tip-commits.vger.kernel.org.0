Return-Path: <linux-tip-commits+bounces-1625-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A81B92A18E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8501F2249B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3057780046;
	Mon,  8 Jul 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPGfe/Ja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/NmVwn62"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2547E591;
	Mon,  8 Jul 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439370; cv=none; b=o31WLIGidHWf5gb1lv+zZIyY6K7maoX3D3chqL9M+y/p+whgo5doV8IgDxNnlpTMU+NuBR5z8W+nMxlC93KUwD/czhi0Ga++hT6ggSsTwCSyuYtLmyz/JOZGUzIsfSHAlhXisBs/rLyofntOA3WrOdnR/0LFk3H/wqiyR23tE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439370; c=relaxed/simple;
	bh=g1nfFzJToez0FGGuBBOT9XQLEJS03rHD+uNOUfvEuL8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZJQP6tcI3YFb+fF79hSBIufuQg/B2ipt6goEHKZ2ZHqVxFtmjYYbbg/X1V8t9/Yxz7AMUy+ynPlaVupy2WpgXs0wvGFJSVg+XsgZNvdOrNhNsRKPttSsmbdxpsisXRd9WWMTqXccHnn3r+ia2I9nOcVWspunJzSW6bNtCUTLmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPGfe/Ja; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/NmVwn62; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 11:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h02IQInx0e5JPLAorVUPa81kR5s8eeJxDL0sJYhqHWg=;
	b=EPGfe/JaJVYJwW3peuHnBYDi85JDBcSybgfg2dnMCJtpi/E9fLrTrJLfw27JlA842736tH
	2XtIxm7N01gAOSjFDdcQ9C3K4UMZR3X8yo2GKFHs666ZIyV9UobQdH1dMoyT8LjkzqGD9v
	GQD7RLEs8/3hIaBzkjhqXO0ge8nFiodjhOmElALA40rLhPo7sz1a7/TPcGaOIsvBwNwcaa
	eCaOvk3SGr9wPFJjcDxa6X0EvAJH1WunFksK1Eq92akUX2bVBBnro48uQXbgyB4Tu2qI3g
	jWjR6LbGVZRwGzaBlJmwZBtQ7kHH9FRljUMUx70pSj0VLW0XW9GX7tvNjYRKwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h02IQInx0e5JPLAorVUPa81kR5s8eeJxDL0sJYhqHWg=;
	b=/NmVwn62JgYaRH7XuhRSbsCqFN0WVtVs2Qwtmanspyl7jSGleNZIsxGasUbmUpkg8kcvnj
	86eFjQZGWqRIeQAA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool/x86: objtool can confuse memory and stack access
Cc: kernel test robot <lkp@intel.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240620144747.2524805-1-alexandre.chartre@oracle.com>
References: <20240620144747.2524805-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936454.2215.16620277258416300859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8e366d83edce3065ff3372bedc281c5e217c0550
Gitweb:        https://git.kernel.org/tip/8e366d83edce3065ff3372bedc281c5e217c0550
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Thu, 20 Jun 2024 16:47:47 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:40:54 -07:00

objtool/x86: objtool can confuse memory and stack access

The encoding of an x86 instruction can include a ModR/M and a SIB
(Scale-Index-Base) byte to describe the addressing mode of the
instruction.

objtool processes all addressing mode with a SIB base of 5 as having
%rbp as the base register. However, a SIB base of 5 means that the
effective address has either no base (if ModR/M mod is zero) or %rbp
as the base (if ModR/M mod is 1 or 2). This can cause objtool to confuse
an absolute address access with a stack operation.

For example, objtool will see the following instruction:

 4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12

as a stack operation (i.e. similar to: mov -0x20(%rbp), %r12).

[Note that this kind of weird absolute address access is added by the
 compiler when using KASAN.]

If this perceived stack operation happens to reference the location
where %r12 was pushed on the stack then the objtool validation will
think that %r12 is being restored and this can cause a stack state
mismatch.

This kind behavior was seen on xfs code, after a minor change (convert
kmem_alloc() to kmalloc()):

>> fs/xfs/xfs.o: warning: objtool: xfs_da_grow_inode_int+0x6c1: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402220435.MGN0EV6l-lkp@intel.com/
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lore.kernel.org/r/20240620144747.2524805-1-alexandre.chartre@oracle.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/decode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3a1d80a..ed6bff0 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -125,8 +125,14 @@ bool arch_pc_relative_reloc(struct reloc *reloc)
 #define is_RIP()   ((modrm_rm & 7) == CFI_BP && modrm_mod == 0)
 #define have_SIB() ((modrm_rm & 7) == CFI_SP && mod_is_mem())
 
+/*
+ * Check the ModRM register. If there is a SIB byte then check with
+ * the SIB base register. But if the SIB base is 5 (i.e. CFI_BP) and
+ * ModRM mod is 0 then there is no base register.
+ */
 #define rm_is(reg) (have_SIB() ? \
-		    sib_base == (reg) && sib_index == CFI_SP : \
+		    sib_base == (reg) && sib_index == CFI_SP && \
+		    (sib_base != CFI_BP || modrm_mod != 0) :	\
 		    modrm_rm == (reg))
 
 #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))

