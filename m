Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01B5412F95
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhIUHih (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:38:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhIUHie (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:38:34 -0400
Received: from zn.tnic (p200300ec2f0d06001218f73da4dba7e9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:600:1218:f73d:a4db:a7e9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8516E1EC0419;
        Tue, 21 Sep 2021 09:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632209819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LKkFguSpbQHHwi/bgcautJBCs/vcPLEypQQVFpzAPoE=;
        b=J3bLnrKLQjNh7Bg1ow1A2QV/7qioJFAqDNXNpdM2Uq/qct3bTWV972lnnd9Np6M/2OfNHB
        rm2Q3NEcfRazckPUADTiWqlqOfS8ZLDuc9AUpQ98E6IvSzJWhyYfFWfHMZ9xD/DJMCnQqn
        ogMHKiN/5dSEe3yuMgBBLkeHB1v7TM4=
Date:   Tue, 21 Sep 2021 09:36:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        marmarek@invisiblethingslab.com, Juergen Gross <jgross@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/setup: Call early_reserve_memory() earlier
Message-ID: <YUmLk/xRsIr/dt3p@zn.tnic>
References: <20210914094108.22482-1-jgross@suse.com>
 <163178944634.25758.17304720937855121489.tip-bot2@tip-bot2>
 <4422257385dbee913eb5270bda5fded7fbb993ab.camel@gmx.de>
 <YUdwMm9ncgNuuN4f@zn.tnic>
 <YUkPsjUUtRewyOn3@archlinux-ax161>
 <YUlTlsVB7gJUVNT0@zn.tnic>
 <YUlYrLG4rLwWw1ge@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUlYrLG4rLwWw1ge@archlinux-ax161>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Sep 20, 2021 at 08:59:40PM -0700, Nathan Chancellor wrote:
> Sure thing. I tested both of my test systems and added a tested-by tag
> to that thread. Glad to hear it was not in vain :)

Thanks!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
