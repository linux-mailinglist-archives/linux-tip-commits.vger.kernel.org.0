Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5847108444
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Nov 2019 18:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfKXRGY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Nov 2019 12:06:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfKXRGY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Nov 2019 12:06:24 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF772082C
        for <linux-tip-commits@vger.kernel.org>; Sun, 24 Nov 2019 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574615183;
        bh=xcebLS6J6XP5yxHYKRl1iBBCcYJyPSa7oDm4voqVEn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TUNTJTU7DIC1H8DYl2qfez3LHi1IRYnUA1eu1A4d2jqHJc/GM2rIaTscZy+oB4VEh
         CQBkA50hOrebCRvb93/WgS4zs8qqJqFZGHzwdXbDPf3tQpWQZSeEXswzwjRGqb78/X
         eRS2a7hPJx6SQkI4k42lLHt/z/A16wXU2xeTml+8=
Received: by mail-wr1-f48.google.com with SMTP id t2so14673927wrr.1
        for <linux-tip-commits@vger.kernel.org>; Sun, 24 Nov 2019 09:06:23 -0800 (PST)
X-Gm-Message-State: APjAAAVinGhIo8hMJTj8hN8VNl7UZfzKuUJubA3/VL3qmzOGLu1V70hd
        ggXhIZonD1mW69omoTGyE4Tr/iz/YCi0ks1evI4TQQ==
X-Google-Smtp-Source: APXvYqxnwrj5N9383JzVbSzIbSfa31TZ//NRGDN/BrbTpb+XWtJGRdSU5J+TdOXXT4DVs+Iw1adhsi8jvuucqN8Kxck=
X-Received: by 2002:a5d:4589:: with SMTP id p9mr11104362wrq.61.1574615181692;
 Sun, 24 Nov 2019 09:06:21 -0800 (PST)
MIME-Version: 1.0
References: <157461245729.21853.17367017341063798964.tip-bot2@tip-bot2>
In-Reply-To: <157461245729.21853.17367017341063798964.tip-bot2@tip-bot2>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 24 Nov 2019 09:06:11 -0800
X-Gmail-Original-Message-ID: <CALCETrUkRN5wnNe-E8kr5zQNdXd777Ce1VcZBsH-+2+Y7d9tJQ@mail.gmail.com>
Message-ID: <CALCETrUkRN5wnNe-E8kr5zQNdXd777Ce1VcZBsH-+2+Y7d9tJQ@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/pti/32: Calculate the various PTI
 cpu_entry_area sizes correctly, make the CPU_ENTRY_AREA_PAGES assert precise
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, stable@kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Nov 24, 2019 at 8:21 AM tip-bot2 for Ingo Molnar
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/urgent branch of tip:
>
> Commit-ID:     4d6dd252b80eddbd7425d0b6b07b239f4f070647
> Gitweb:        https://git.kernel.org/tip/4d6dd252b80eddbd7425d0b6b07b239f4f070647
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Sun, 24 Nov 2019 11:21:44 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Sun, 24 Nov 2019 14:22:27 +01:00
>
> x86/pti/32: Calculate the various PTI cpu_entry_area sizes correctly, make the CPU_ENTRY_AREA_PAGES assert precise
>

Thanks, much better!
