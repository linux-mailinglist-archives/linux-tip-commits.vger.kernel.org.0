Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D497CBA23
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Oct 2023 07:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJQF2k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Oct 2023 01:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjJQF2j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Oct 2023 01:28:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAEBF2;
        Mon, 16 Oct 2023 22:28:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57768C433C7;
        Tue, 17 Oct 2023 05:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697520516;
        bh=cd+YCcvaHShnXv8nfPjDdkeIq4Z59L04bYAn6IBtZqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntF7ZIGwmlpol29wyVdJbpc8ID4cq0mtwqrWBDTeXAskry0rMCdoEruNogvmNsU+t
         NqQxKvSGs75U5msvpeYdfieKunLtc052QQH4DU0a1YqSij6JKj9AjYwiUx6IJF+vx7
         3hB2jykjVWnSdGmbbsidS3PKfrMzY2XXRKAyV3YNzG/4pjrrbMOWhmgZSVxAIMb1g8
         pl21yGph/khjwE3zcQaY+r6QNKk3FbGILEtQcXNPrSm5LeBHiMpU9qNdbVOBCSBiFI
         IXqh9/KduF32ZjkJiSMiVWKflbBYScyvvDDo4TgBsQLWoenLVAbzi/Zc4K0CCIrqDV
         +TNT6LtjCrf8g==
Date:   Mon, 16 Oct 2023 22:28:34 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Kaplan, David" <David.Kaplan@amd.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231017052834.v53regh66hspv45n@treble>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231016211040.GA3789555@dev-arch.thelio-3990X>
 <20231016212944.GGZS2rSCbIsViqZBDe@fat_crate.local>
 <20231016214810.GA3942238@dev-arch.thelio-3990X>
 <SN6PR12MB270273A7D1AF5D59B920C94194D6A@SN6PR12MB2702.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB270273A7D1AF5D59B920C94194D6A@SN6PR12MB2702.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Oct 17, 2023 at 04:31:09AM +0000, Kaplan, David wrote:
> I think I found the problem, although I'm not sure the best way to fix it.
> 
> When KCSAN is enabled, GCC generates lots of constructor functions named _sub_I_00099_0 which call __tsan_init and then return.  The returns in these are generally annotated normally by objtool and fixed up at runtime.  But objtool runs on vmlinux.o and vmlinux.o does not include a couple of object files that are in vmlinux, like init/version-timestamp.o and .vmlinux.export.o, both of which contain _sub_I_00099_0 functions.  As a result, the returns in these functions are not annotated, and the panic occurs when we call one of them in do_ctors and it uses the default return thunk.
> 
> This difference can be seen by counting the number of these functions in the object files:
> $ objdump -d vmlinux.o|grep -c "<_sub_I_00099_0>:"
> 2601
> $ objdump -d vmlinux|grep -c "<_sub_I_00099_0>:"
> 2603
> 
> If these functions are only run during kernel boot, there is no speculation concern.  My first thought is that these two object files perhaps should be built without -mfunction-return=thunk-extern.  The use of that flag requires objtool to have the intended behavior and objtool isn't seeing these files.
> 
> Perhaps another option would be to not compile these two files with KCSAN, as they are already excluded from KASAN and GCOV it looks like.

I think the latter would be the easy fix, does this make it go away?

diff --git a/init/Makefile b/init/Makefile
index ec557ada3c12..cbac576c57d6 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -60,4 +60,5 @@ include/generated/utsversion.h: FORCE
 $(obj)/version-timestamp.o: include/generated/utsversion.h
 CFLAGS_version-timestamp.o := -include include/generated/utsversion.h
 KASAN_SANITIZE_version-timestamp.o := n
+KCSAN_SANITIZE_version-timestamp.o := n
 GCOV_PROFILE_version-timestamp.o := n
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 3cd6ca15f390..c9f3e03124d7 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -19,6 +19,7 @@ quiet_cmd_cc_o_c = CC      $@
 
 ifdef CONFIG_MODULES
 KASAN_SANITIZE_.vmlinux.export.o := n
+KCSAN_SANITIZE_.vmlinux.export.o := n
 GCOV_PROFILE_.vmlinux.export.o := n
 targets += .vmlinux.export.o
 vmlinux: .vmlinux.export.o
