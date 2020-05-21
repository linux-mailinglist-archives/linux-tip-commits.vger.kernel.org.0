Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DA71DC78C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 May 2020 09:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEUH0H (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 May 2020 03:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEUH0H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 May 2020 03:26:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8DAC061A0E;
        Thu, 21 May 2020 00:26:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c82002db258470e3f635c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8200:2db2:5847:e3f:635c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7B311EC02B1;
        Thu, 21 May 2020 09:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590045964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jljlzrbe6Cwi8pmzDsl0C5++jb9+/KEj29n629dTZKI=;
        b=VSxbzCRmWCEe1ed3hI2g/V77fa5/yViTapiMajoyKHz39l8IWQw56zWCkidnqoTcGYjdrP
        Mz0jukKM9Glxyvn2aQwfdliWFDnCd6MOm13YoIuqo2P00V35xyKDMVh/Ocdadm7RTtUz+f
        wokIuL8M8j7JPVoNK+6KBkgDxRjRICw=
Date:   Thu, 21 May 2020 09:25:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN
 instrumentation
Message-ID: <20200521072557.GA10099@zn.tnic>
References: <20200511204150.27858-18-will@kernel.org>
 <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
 <20200520221712.GA21166@zn.tnic>
 <CANpmjNPsEMF8qq4qHoJEDb8mi211QzXODvnakh2fj3BOw+56MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPsEMF8qq4qHoJEDb8mi211QzXODvnakh2fj3BOw+56MQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, May 21, 2020 at 12:30:39AM +0200, Marco Elver wrote:
> This should be fixed when the series that includes this commit is applied:
> https://lore.kernel.org/lkml/20200515150338.190344-9-elver@google.com/

Yap, that fixes it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
