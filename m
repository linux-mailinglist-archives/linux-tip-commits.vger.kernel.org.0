Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E3C31927A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 19:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBKSrR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Feb 2021 13:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBKSq6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Feb 2021 13:46:58 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870DAC06178A
        for <linux-tip-commits@vger.kernel.org>; Thu, 11 Feb 2021 10:46:18 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id r75so7214143oie.11
        for <linux-tip-commits@vger.kernel.org>; Thu, 11 Feb 2021 10:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91GcU1VsBVz3FYSR+U/pa4MztTHbqU+7RC9yCYvzYc0=;
        b=D75yU+4hQYTZNquIdcs8budOC8Xa/TjmEPESrTS6vnG1TcE3DidrBRttPPRsawIXxy
         /lxfWlpqAg+LbTH7UwR6MCcjagqL7K/15Xio7Ua91TS082iUBO5trwzNXxZPZrQ4098M
         7lA4V2N8q+gOvNB9KGMRFAPk3ggi7XiTzoeUdDd4HBtfFKh57mo4V4J21OiZE00esE+8
         oygAEsgp9VrumXQ69HdVk/efA3aWIeunaJZ2Vxbk+7U5QPLvv+pOuG3/9XHHMpBPRjnF
         3fU7EeDs1aAROMHMyLl8Uxy6r48LMELXXLxW8gBPEHv3VEMtBaM/DUQq6ggMB/v/aZx0
         zYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91GcU1VsBVz3FYSR+U/pa4MztTHbqU+7RC9yCYvzYc0=;
        b=m15gihaJR8RS8rPJkDBD+IbbkSLZQh/jln5bog+21X+C0Sz0OGRkkYVJ8QBtTNexyj
         gJbhVQ3XTOc0RAu4OlkyytMof3MCZNHtavHEn3YBt6e36DIQhQiChowiaBUcpLY8CiuD
         3s37i1NF+REkUX6pWusK6RoZaI9odyPMV9uA3QXLH7+NfOAa8uHlApTnCjSrsEmra7NL
         h9MO0oQWGCPbHBh3YuS2umwyvacpXhdYHHR+rk7/exBnvozM+z4aJQLw4GTBvBPwB7pD
         U54WTPG5jTAZ8Grh4Rwcx5ai88RxSO2RcjlHPoKeDvX2uOoiUTTDid50erUFUaUDjaJM
         /ucQ==
X-Gm-Message-State: AOAM531XOYojantszF5JwH37OnHKb4oqX/vCSZwNIZvDqD2QbouXu7Hx
        tPbotCfQ+n9SqAnMtIYxIB/o0tBRBvY4MWKvBV8e+A==
X-Google-Smtp-Source: ABdhPJwnLvs6LPAcpWrc/9dCYZHZYfS+QKV2BP8u5znNiYmi4A5EUDRhQnB5T/HqH2lP0H40DExXmh5igB9xCy9ahFA=
X-Received: by 2002:a05:6808:294:: with SMTP id z20mr3709431oic.14.1613069177774;
 Thu, 11 Feb 2021 10:46:17 -0800 (PST)
MIME-Version: 1.0
References: <ba6b6c0f0dd5acbba66e403955a967d9fdd1726a.1607983452.git.jpoimboe@redhat.com>
 <160812658044.3364.4188208281079332844.tip-bot2@tip-bot2> <dded80b60d9136ea90987516c28f93273385651f.camel@mengyan1223.wang>
 <YCU3Vdoqd+EI+zpv@kroah.com>
In-Reply-To: <YCU3Vdoqd+EI+zpv@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Feb 2021 10:46:05 -0800
Message-ID: <CAKwvOd=GHdkvAU3u6ROSgtGqC_wrkXo8siL1nZHE-qsqSx0gsw@mail.gmail.com>
Subject: Re: [tip: objtool/urgent] objtool: Fix seg fault with Clang
 non-section symbols
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Feb 11, 2021 at 5:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 11, 2021 at 09:32:03PM +0800, Xi Ruoyao wrote:
> > Hi all,
> >
> > The latest GNU assembler (binutils-2.36.1) is removing unused section symbols
> > like Clang [1].  So linux-5.10.15 can't be built with binutils-2.36.1 now.  It
> > has been reported as https://bugzilla.kernel.org/show_bug.cgi?id=211693.

Xi,
Happy Lunar New Year to you, too, and thanks for the report.  Did you
observe such segfaults for older branches of stable?

> 2.36 of binutils fails to build the 4.4.y tree right now as well, but as
> objtool isn't there, I don't know what to do about it :(

Greg,
There may be multiple issues in the latest binutils release for the
kernel; we should still avoid segfaults in host tools so I do
recommend considering this patch for inclusion at least into 5.10.y.
Arnd's report in https://github.com/ClangBuiltLinux/linux/issues/1207
mentions this was found via randconfig testing, so likely some set of
configs is needed to reproduce reliably.

Do you have more info about the failure you're observing? Trolling
lore, I only see:
https://lore.kernel.org/stable/YCLeJcQFsDIsrAEc@kroah.com/
(Maybe it was reported on a different list; I only searched stable ML).
-- 
Thanks,
~Nick Desaulniers
