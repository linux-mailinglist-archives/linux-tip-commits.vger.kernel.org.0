Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7271E3883DC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 02:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhESApg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 20:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235375AbhESApg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 20:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621385057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwTV7Kjj6RrOTTD0I2CX5CsxsnrWqAGskz6Ldbn+/74=;
        b=RS0RNR4bDnHEOBFwj+nl3ddPEEmaaAHi0sy/D371KwVKffmY44TDSCRAntcAyJhPqrdYPT
        uMMD7K6M9QHFN+73dQg7ZFVerRPMEvnHEu+hi6tfs/6SZbU+Ivo8Vp0nbCM4hCBrEr2d99
        E/zH6Ipbynhh9GRsvaaezgnjbWpRVw4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-7LbvmCpqOfSLYyydLcPvzQ-1; Tue, 18 May 2021 20:44:15 -0400
X-MC-Unique: 7LbvmCpqOfSLYyydLcPvzQ-1
Received: by mail-qv1-f69.google.com with SMTP id l19-20020a0ce5130000b02901b6795e3304so8850293qvm.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 18 May 2021 17:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YwTV7Kjj6RrOTTD0I2CX5CsxsnrWqAGskz6Ldbn+/74=;
        b=tgvFrCu931k32DTINo0jCA8Urn7M9/orZ3gnj6l0fOlWrvCivcTPjyczEzvbUsFTVn
         84yNpLo8vBal+d8lSzs8fTW5x/0Ie2CM7G92HwAWzQRxW562vsokelTq9R28ODNV+MYg
         RsbGSyVmHTdg+T/A1A+dtqjJ4qEC+ispIAJWE7MLe3/WApmKRIeVMQsWQYrAz+ftJsHj
         AlVpPDk6hzJ8H4mOIdZhsPRO8f1BRLiTpHSg3L7EgaNZBDSIBYNcrr/b5T421Gv72wrl
         MYT/zH0Q9CelislGYoUHouGG9LF4T/rMdcQsyKGdnyX2tks64xTxmQBxwuijeuebO/jH
         i1mg==
X-Gm-Message-State: AOAM532Q2fCtoxW73+qYhxhxiZfMlNS2u+0pAqRQAeCG4mM5JCimi7Aq
        rZv3qCpAlPK8GC9M4wlot0sB2Rlan9Yi7uN1beHWAdZFDUi83K/2GGUy5gZ2RRfr/ioQP1WUns+
        xBr6+ubxDywsJkmvUezZ3mTIzVnZfK0w=
X-Received: by 2002:ac8:57d3:: with SMTP id w19mr7985508qta.75.1621385054692;
        Tue, 18 May 2021 17:44:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/Q1QiH+3hhEaWnwd9y0dfF8Sdg6/iOfxvq1qK25qepn9oxe5obi9OdahD47I+lnDGQNYZ4A==
X-Received: by 2002:ac8:57d3:: with SMTP id w19mr7985479qta.75.1621385054364;
        Tue, 18 May 2021 17:44:14 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id k2sm12508513qtg.68.2021.05.18.17.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 17:44:14 -0700 (PDT)
Date:   Tue, 18 May 2021 19:44:11 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        willy@infradead.org, masahiroy@kernel.org, michal.lkml@markovi.net
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <20210519004411.xpx4i6qcnfpyyrbj@treble>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
 <20210518195004.GD21560@worktop.programming.kicks-ass.net>
 <20210518202443.GA48949@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518202443.GA48949@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, May 18, 2021 at 10:24:43PM +0200, Peter Zijlstra wrote:
> OK, willy followed up on IRC, and it turns out there's a kbuild
> dependency missing; then objtool changes we don't rebuild:
> 
>   arch/x86/entry/vdso/vma.o
> 
> even though we should, this led to an unpatched 2 byte jump-label and
> things went sideways. I'm not sure I understand the whole build
> machinery well enough to know where to begin chasing this.
> 
> Now, this file is mighty magical, due to:
> 
> arch/x86/entry/vdso/Makefile:OBJECT_FILES_NON_STANDARD  := y
> arch/x86/entry/vdso/Makefile:OBJECT_FILES_NON_STANDARD_vma.o    := n
> 
> Maybe that's related.

I'm not exactly thrilled that objtool now has the power to easily brick
a system :-/  Is it really worth it?

Anyway, here's one way to fix it.  Maybe Masahiro has a better idea.

From f88b208677953bc445db08ac46b6e4259217bb8a Mon Sep 17 00:00:00 2001
Message-Id: <f88b208677953bc445db08ac46b6e4259217bb8a.1621384807.git.jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Date: Tue, 18 May 2021 18:59:15 -0500
Subject: [PATCH] kbuild: Fix objtool dependency for
 'OBJECT_FILES_NON_STANDARD_<obj> := n'

"OBJECT_FILES_NON_STANDARD_vma.o := n" has a dependency bug.  When
objtool source is updated, the affected object doesn't get re-analyzed
by objtool.

Peter's new variable-sized jump label feature relies on objtool
rewriting the object file.  Otherwise the system can fail to boot.  That
effectively upgrades this minor dependency issue to a major bug.

The problem is that variables in prerequisites are expanded early,
during the read-in phase.  The '$(objtool_dep)' variable indirectly uses
'$@', which isn't yet available when the target prerequisites are
evaluated.

Use '.SECONDEXPANSION:' which causes '$(objtool_dep)' to be expanded in
a later phase, after the target-specific '$@' variable has been defined.

Fixes: b9ab5ebb14ec ("objtool: Add CONFIG_STACK_VALIDATION option")
Fixes: ab3257042c26 ("jump_label, x86: Allow short NOPs")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 949f723efe53..34d257653fb4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -268,7 +268,8 @@ define rule_as_o_S
 endef
 
 # Built-in and composite module parts
-$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
+.SECONDEXPANSION:
+$(obj)/%.o: $(src)/%.c $(recordmcount_source) $$(objtool_dep) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
@@ -349,7 +350,7 @@ cmd_modversions_S =								\
 	fi
 endif
 
-$(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
+$(obj)/%.o: $(src)/%.S $$(objtool_dep) FORCE
 	$(call if_changed_rule,as_o_S)
 
 targets += $(filter-out $(subdir-builtin), $(real-obj-y))
-- 
2.31.1

