Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875177F66D5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Nov 2023 20:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjKWTAr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Nov 2023 14:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWTAq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Nov 2023 14:00:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99861B3
        for <linux-tip-commits@vger.kernel.org>; Thu, 23 Nov 2023 11:00:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ff26d7c0a6so167260366b.2
        for <linux-tip-commits@vger.kernel.org>; Thu, 23 Nov 2023 11:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700766051; x=1701370851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=717qANo9IFyyNeZDc8GQKEAbOtQz1mcsrQpltrJlB1o=;
        b=AtjHcKMuMk9H+4JzmFq3OUiO8cyl6W2zyoG6Lob8HZpWqVJdYAFMcnRAMZ05egxQny
         EnceKK6ur76NbKGi4DTcogr1wx154r1okzMMcFyIbBOwGIbY89gd05xFn+fSAIf14JU1
         XIgY9b50a618TUXAWPOyOmuGNHLwxXQP2UN/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700766051; x=1701370851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=717qANo9IFyyNeZDc8GQKEAbOtQz1mcsrQpltrJlB1o=;
        b=CwgM/dImUdyd4w+mN86CGcuOoqegHU1aZDSajpmY/ttUGo+d0Cu/rQkmLvoqFWiqCL
         G6BLw5vF0qjX1LoA+HES2Tcx1R8jE5KzSOA84awVj3FVkzKl1S/1MKd4VMRXy8vzbee0
         pGMRgQDbDQNQDYw3cMsmIXJDpORRXwTW49dFUPsT7/VJ1TLu2n8hpgkW5a5DqfuPIfu9
         NlM3zMd2dd/dkaFUm8zrIMTt5CDqFwcH9U6T9AvEda42cpQUFW/s0OVhePpd08e/M+Rx
         6FQIU3jXZuuO87XAmZlrnae9INSD6zJ6kNWUi0l9ypFtxwMXY6PDO+L/LKgb0WwaiXiF
         XnPA==
X-Gm-Message-State: AOJu0YwKYSYFLYwzrnzmyU5viuNJ9tBg/uT+pMBn/wOnYNEV+X5gCDc+
        W6R3U3stKGycFT7/Q9VNwiiPrsqpCzTGnr8x6uyFS/Uq
X-Google-Smtp-Source: AGHT+IGw7xhoCCihbYdsoM2g7xH/v8DN9m4CoGIexAOA+QJSF6yKzQ0S1teXrmdPVBEQW5gwu2OuVg==
X-Received: by 2002:a17:906:12:b0:9ff:7164:c1fa with SMTP id 18-20020a170906001200b009ff7164c1famr181693eja.13.1700766051107;
        Thu, 23 Nov 2023 11:00:51 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm1106405ejc.22.2023.11.23.11.00.50
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 11:00:50 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so168829066b.1
        for <linux-tip-commits@vger.kernel.org>; Thu, 23 Nov 2023 11:00:50 -0800 (PST)
X-Received: by 2002:a17:906:6bcd:b0:a03:7de1:374f with SMTP id
 t13-20020a1709066bcd00b00a037de1374fmr179408ejs.25.1700766050187; Thu, 23 Nov
 2023 11:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20231122163700.400507-1-michael.roth@amd.com> <170073547546.398.2637807593174571076.tip-bot2@tip-bot2>
In-Reply-To: <170073547546.398.2637807593174571076.tip-bot2@tip-bot2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Nov 2023 11:00:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=JDhLdEry=U1-iO1foL_j5T37qVE6_MEHqvj31HO1Lw@mail.gmail.com>
Message-ID: <CAHk-=wg=JDhLdEry=U1-iO1foL_j5T37qVE6_MEHqvj31HO1Lw@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Ensure input to pfn_to_kaddr() is treated
 as a 64-bit type
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, 23 Nov 2023 at 02:31, tip-bot2 for Michael Roth
<tip-bot2@linutronix.de> wrote:
>
> On 64-bit platforms, the pfn_to_kaddr() macro requires that the input
> value is 64 bits in order to ensure that valid address bits don't get
> lost when shifting that input by PAGE_SHIFT to calculate the physical
> address to provide a virtual address for.

Bah. The commit is obviously fine, but can we please just get rid of
that broken pfn_to_kaddr() thing entirely?

It's a bogus mis-spelling of pfn_to_virt(), and I don't know why that
horrid thing exists. In *all* other situations we talk about "virt"
for kernel virtual addresses, I don't know where that horrid "kaddr"
came from (ie "virt_to_page()" and friends).

Most notably, we have "virt_to_pfn()" being quite commonly used. We
don't even have that kaddr_to_pfn(), which just shows *how* bogus this
whole "pfn_to_kaddr()" crud is.

The good news is that there aren't a ton of users. Anybody willing to
just do a search-and-replace and get rid of this pointless and wrong
thing?

Using "pfn_to_virt()" has the added advantage that we have a generic
implementation of it that isn't duplicated pointlessly for N
architectures, and that didn't have this bug:

  static inline void *pfn_to_virt(unsigned long pfn)
  {
        return __va(pfn) << PAGE_SHIFT;
  }
  #define pfn_to_virt pfn_to_virt

Hmm?

Amusingly (or sadly), we have s390 holding up the flag of sanity, and having

    #define pfn_to_kaddr(pfn)  pfn_to_virt(pfn)

and then we'd only need to fix the hexagon version of that macro
(since Hexagon made its own version, with the old bug - but I guess
Hexagon is 32-bit only and hopefully never grows 64-bit (??) so maybe
nobody cares).

           Linus
