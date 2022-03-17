Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55174DD0A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Mar 2022 23:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiCQWYV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 17 Mar 2022 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiCQWYT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 17 Mar 2022 18:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAB66443E4
        for <linux-tip-commits@vger.kernel.org>; Thu, 17 Mar 2022 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647555781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sv3UUAVB2KPZ5L0mxg1wFQw0ov6G6R3jsnNctmpYwvw=;
        b=FAobd7dvev6D0aSt9yvgLuuwMkJliNX3Fjgi+TIwghAaY1OcI2DOOzjlVmGQAF6NmDLwzj
        XjEfFNGXNfbTKyEycENOS4GX7TnZadyqJuoDH/HOp0NdQsQPHdy32p2yE1UI6CiAeukVVV
        3yuqfNRWln1mK2SxoPFzsWvU3Yb0XuY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-dbfnkSjvNQehw05h1KoLow-1; Thu, 17 Mar 2022 18:22:58 -0400
X-MC-Unique: dbfnkSjvNQehw05h1KoLow-1
Received: by mail-qk1-f198.google.com with SMTP id u17-20020a05620a431100b004765c0dc33cso4280181qko.14
        for <linux-tip-commits@vger.kernel.org>; Thu, 17 Mar 2022 15:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sv3UUAVB2KPZ5L0mxg1wFQw0ov6G6R3jsnNctmpYwvw=;
        b=D2BvXOctnN5HhUwm7neI01CyP7A3F+R6RqGZlmfEvoIo6oEpbqtDQ0gkExuxCBScNC
         RMfnYabi3XzqWHp4X4lzslZ/mwCJgPXhKMDppKX4ku8tyoHnvez4nozF8xS2OhGKdDEt
         MGyQWPUb4bYpvhvCVsdkSDTn9uf82rLkhNrpoC7RMDgx9LRiu9AImARv0bKfOo7oF9Wu
         kINkzsiH7Ncla44r1cqGVPQei2MlwdawF32Eu+6Wc13xY+cZ2KnJ53z93uVSdeOGs6Fv
         CP8gF8we3Z2oAKA1GxQsKvSwt6B4T4feEtQFl53UsHgG/L45F9YkU69aQv2z/Vy7Dq6W
         lwkw==
X-Gm-Message-State: AOAM532qOGOFci+yuOGYkY48Zn844KP1+aNwaYUtk+KOQ2NzOaPIOyNG
        wMA4zu/PKlMiyLF3siBUs4NxUgrArSV5DLJ5YzmuKFoYZcWFhMwjyKz+kvnnKi9blYVzaG2mlAZ
        BGC3fWHm9GfaEvUo4e1aqNKBWhf7Tgng=
X-Received: by 2002:a05:620a:2481:b0:67b:39ef:b3eb with SMTP id i1-20020a05620a248100b0067b39efb3ebmr4245603qkn.188.1647555778246;
        Thu, 17 Mar 2022 15:22:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB5EHpzybgcaF3fhLBPNrQL4vv70Dh880xKSomJoQSZ34rgt+KARoQMjBGMUhTqVX0eNgzUA==
X-Received: by 2002:a05:620a:2481:b0:67b:39ef:b3eb with SMTP id i1-20020a05620a248100b0067b39efb3ebmr4245596qkn.188.1647555778037;
        Thu, 17 Mar 2022 15:22:58 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85842000000b002e1ec550506sm3755079qth.87.2022.03.17.15.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 15:22:57 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:22:54 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/core] objtool: Find unused ENDBR instructions
Message-ID: <20220317222254.lm2f2337jejcf3uu@treble>
References: <20220308154319.763643193@infradead.org>
 <164734101940.16921.11639161864874862247.tip-bot2@tip-bot2>
 <a5fa50d9f00542de8a6ad7a3fe0c49b3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5fa50d9f00542de8a6ad7a3fe0c49b3@AcuMS.aculab.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Mar 15, 2022 at 03:39:52PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > 
> > objtool: Find unused ENDBR instructions
> > 
> > Find all ENDBR instructions which are never referenced and stick them
> > in a section such that the kernel can poison them, sealing the
> > functions from ever being an indirect call target.
> 
> Thought, what happens if the only indirect call is from
> code in a module?

Then <boom>, I guess.  Is it safe to assume in-tree modules don't need
to do indirect calls to exported functions?  I guess we'll find out :-)

-- 
Josh

