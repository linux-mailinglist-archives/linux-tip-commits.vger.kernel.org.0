Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4F9D0AB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2019 15:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfHZNd1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Aug 2019 09:33:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42124 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbfHZNd1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Aug 2019 09:33:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id m44so26495056edd.9
        for <linux-tip-commits@vger.kernel.org>; Mon, 26 Aug 2019 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bcUfL34FoYp4/VabITIx6X/hBshWWuaQCv3+2NB9Wuo=;
        b=uNdf7j98900+3G56FRLP6n5FYs7OQNYJAikxCojCx9KA+DxauVKt+ZYG9nGdLUDcIg
         3jJHThfnxMGoOflE9QMP7dvLmOurLC/5iEe8aY39OkqbfblIkF8lCaoiah7lSbjDwI37
         wNWjcVKwPD9yhjQcHd1oGOyeg7idIF9SeNUBIMPM8Tl96hGaODG4jYNCo6jkfvvWuYoU
         A4jJHSzeU3o+Nmf9c/fi9uSBOKt5n85GzBhlLtig+WxWfNHa6shtmOrGAElgs924psRC
         7xi0dWry0ZRHo/BmCfyC5VS2kR7vwoUpp9XfZUEWHzxm1rFyMyuFp6NxKA5rdmJFgGCQ
         oo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bcUfL34FoYp4/VabITIx6X/hBshWWuaQCv3+2NB9Wuo=;
        b=UPj56BFfBTILGXfcK1HaFjvRYk5JA2QdimJvC1d6aGJfxpmyO5b98K/XJBhI+BXi+J
         gTRB+8hXh0/o85KvHMbri94C2TicltnrURrxRuRS/DN1ONs8JYgJEF+HDPXqgYwGGBx4
         P2r9sJyibwmuWVnVzMpw59uGVom4Z4yJKrqk4+OinIeDAF6whL0M7mZzD9mSpBPciPvz
         9MdBp0g/fAGAEXCmDnsDG9Z6xVsa7WHlz+6O9BvgE/nVtZUfzUbxgiW0C/4XcEJhZvTc
         WGAkFWBbtLsdnYd+eBOGwsmowz4wFJxnois29EMcf4MNwpjVTLEH0Ajus4JGu/iJTpkD
         lh2g==
X-Gm-Message-State: APjAAAWFE6HQY8hiHHCWBkRCyIT2yWXiqRuEWtLUw4nKjCN4oUgr8wFI
        WOVvxtLyGJhVe2DikXcSEWyUcg==
X-Google-Smtp-Source: APXvYqwEyTAOm70GPqxQ0JdvxB8u4mVlVB3HNyBKxvtxr+6ex91ykH53z1B8TzSHnaxfQXPoFelQbA==
X-Received: by 2002:a17:906:34c2:: with SMTP id h2mr16368397ejb.227.1566826405105;
        Mon, 26 Aug 2019 06:33:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i1sm1294470edi.13.2019.08.26.06.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 06:33:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1101D10050C; Mon, 26 Aug 2019 16:33:26 +0300 (+03)
Date:   Mon, 26 Aug 2019 16:33:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        x86@kernel.org, mingo@kernel.org, kirill.shutemov@linux.intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/boot/compressed/64: Fix boot on machines
 with broken E820 table
Message-ID: <20190826133326.7cxb4vbmiawffv2r@box>
References: <20190813131654.24378-1-kirill.shutemov@linux.intel.com>
 <tip-0a46fff2f9108c2c44218380a43a736cf4612541@git.kernel.org>
 <caa30daa-9ed5-e293-f6cd-ff261c995e1e@embeddedor.com>
 <20190826071539.GB27636@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826071539.GB27636@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Aug 26, 2019 at 09:15:39AM +0200, Borislav Petkov wrote:
> On Sun, Aug 25, 2019 at 10:33:15PM -0500, Gustavo A. R. Silva wrote:
> > Hi all,
> > 
> > On 8/19/19 9:16 AM, tip-bot for Kirill A. Shutemov wrote:
> > [..]
> > > 
> > > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> > > index 5f2d03067ae5..2faddeb0398a 100644
> > > --- a/arch/x86/boot/compressed/pgtable_64.c
> > > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > > @@ -72,6 +72,8 @@ static unsigned long find_trampoline_placement(void)
> > >  
> > >  	/* Find the first usable memory region under bios_start. */
> > >  	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
> > > +		unsigned long new;
> > > +
> > >  		entry = &boot_params->e820_table[i];
> > >  
> > >  		/* Skip all entries above bios_start. */
> > > @@ -84,15 +86,20 @@ static unsigned long find_trampoline_placement(void)
> > >  
> > >  		/* Adjust bios_start to the end of the entry if needed. */
> > >  		if (bios_start > entry->addr + entry->size)
> > 
> > Notice that if this condition happens to be false, we end up with an
> > uninitialized variable *new*.
> 
> Yap, good catch.

:facepalm:

> > What would be the right value to assign to *new* at declaration under
> > this condition?
> 
> Looking at the changed flow of the loop, how we use new instead of
> bios_start and how we assign new back to bios_start, I think we should
> do:
> 
> 		unsigned long new = bios_start;
> 
> at the beginning...

Right.

What about this:

From b613c675e6690ef5608a5abf71d90e15ced31b2b Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 26 Aug 2019 16:26:01 +0300
Subject: [PATCH] x86/boot/compressed/64: Fix missining initialization in
 find_trampoline_placement()

Gustavo noticed that 'new' can be left uninitialized if 'bios_start'
happens to be less or equal to 'entry->addr + entry->size'.

Initialize the variable at the start of the iteration to current value
of 'bios_start'.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Fixes: 0a46fff2f910 ("x86/boot/compressed/64: Fix boot on machines with broken E820 table")
---
 arch/x86/boot/compressed/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2faddeb0398a..c8862696a47b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -72,7 +72,7 @@ static unsigned long find_trampoline_placement(void)
 
 	/* Find the first usable memory region under bios_start. */
 	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
-		unsigned long new;
+		unsigned long new = bios_start;
 
 		entry = &boot_params->e820_table[i];
 
-- 
 Kirill A. Shutemov
