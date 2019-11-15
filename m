Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23497FD814
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 09:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOIpK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 03:45:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOIpK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 03:45:10 -0500
Received: from zn.tnic (p200300EC2F0CC300B4C5AF24BE56B25A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:b4c5:af24:be56:b25a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 217C01EC0D01;
        Fri, 15 Nov 2019 09:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573807509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EygHJNs6WC+US22c+zePRk0Sw5nzmHw2YzebvrL7LPY=;
        b=NMy+M4pUs21vT6AN2LOtZfL4BMZq8yQ2ZMH78ZXLHQrOyeb2HSCz30MxSA1ocj04vTggte
        Qfx1uEJ2fXAj5J52vxhGxgzhFRqxPRn4C8cdKvw0uAvqreItD/Co3OGXpcP1CDV5Giso1c
        OhudAiH3vIcbt90N0AuTeMKwgOc/ZDw=
Date:   Fri, 15 Nov 2019 09:45:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
Message-ID: <20191115084509.GC18929@zn.tnic>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic>
 <73ffdd4c-d74d-e3c0-7cd5-f97e7061caeb@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73ffdd4c-d74d-e3c0-7cd5-f97e7061caeb@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Nov 15, 2019 at 04:41:13PM +0800, Cao jin wrote:
> Sorry for the confusion. I asked my college to send the patch for me
> because my git send-email has been down for a while,

Your "git send-email has been down"? What does that even mean?

If you do ask your colleague to send patches for you, he needs to add
his SOB under yours because it shows this way that the patch went
through him and it is important to know the path a patch took upstream.

> I guess it is because our mail server is upgrading.

Well, something's happening because I've received a couple of bounces
from your mail address in the past weeks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
